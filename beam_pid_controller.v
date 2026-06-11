`timescale 1ns / 1ps

module beam_pid_controller (
    input  wire        clk,
    input  wire        rst_n,
    
    // ADC Inputs (24-bit AD7193)
    (*mark_debug ="true"*) input  wire [23:0] adc_ch1_data, // X
    input  wire [23:0] adc_ch2_data, // Y
    input  wire [23:0] adc_ch3_data, // SUM
    input  wire        adc_ch3_valid, // Trigger PI calculation on SUM valid
    
    // DAC Outputs (16-bit)
    output reg  [15:0] dac_1_data, // X Piezo
    output reg  [15:0] dac_2_data, // Y Piezo
    output reg         dac_valid
);

    // AD7193 Bipolar Format: 0x800000 = 0V, centre at mid
    localparam [23:0] ADC_CENTER = 24'h800000;
    
    // PDQ_MIN_SUM = 0.2V. 
    // Assuming 1.25V full scale -> 8,388,607 counts
    // 0.2V = (0.2 / 1.25) * 8388607 = 1342177
    localparam signed [24:0] MIN_SUM_THRESH = 25'sd1342177;
    
    // Integral Clamp limits (Q16 format: 1.0 = 65536)
    localparam signed [47:0] INT_MAX = 48'sd1048576;   
    localparam signed [47:0] INT_MIN = -48'sd1048576;

    // DAC Center (16-bit mid-scale)
    localparam signed [47:0] DAC_CENTER = 48'sd32768;

    // ==========================================
    // Internal Signals & Debug
    // ==========================================
      reg [3:0] state;
    localparam IDLE         = 0;
    localparam SUBTRACT     = 1;
    localparam WAIT_LUT     = 2;
    localparam MULTIPLY     = 3;
    localparam PID_CALC_INT    = 4;
    localparam PID_CALC_OUT    = 5;
    localparam SCALE_OUT_CALC  = 6;
    localparam SCALE_OUT_CLAMP = 7;
    localparam DONE            = 8;

      reg signed [24:0] vx_raw;
      reg signed [24:0] vy_raw;
      reg signed [24:0] vsum_raw;
    
      reg sum_ok;

    // LUT Signals
    wire [10:0] lut_index = vsum_raw[22:12];
    wire [17:0] lut_inv_sum;
    
    vsum_inv_lut inv_lut_inst (
        .clk(clk),
        .index(lut_index),
        .inv_sum(lut_inv_sum)
    );
    
    // Multiplication Signals (43 bits = 25 bit raw * 18 bit unsigned lut)
    reg signed [42:0] x_mult;
    reg signed [42:0] y_mult;
    
      reg signed [31:0] ex_q16;
      reg signed [31:0] ey_q16;
    
      reg signed [47:0] int_x; // Integral accumulator
      reg signed [47:0] int_y;
    
      reg signed [47:0] ux_q16; // PI Output
      reg signed [47:0] uy_q16;

    // Temporary signals for PI and DAC
    reg signed [47:0] next_int_x, next_int_y;
    reg signed [47:0] dac_x_calc, dac_y_calc;

    // ==========================================
    // State Machine
    // ==========================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state      <= IDLE;
            dac_1_data <= 16'd32768;
            dac_2_data <= 16'd32768;
            dac_valid  <= 1'b0;
            int_x      <= 0;
            int_y      <= 0;
        end else begin
            dac_valid <= 1'b0; // Default pulse
            
            case (state)
                IDLE: begin
                    if (adc_ch3_valid) begin
                        state <= SUBTRACT;
                    end
                end
                
                SUBTRACT: begin
                    // Convert bipolar format to signed integers centered at 0
                    vx_raw   <= $signed({1'b0, adc_ch1_data}) - $signed({1'b0, ADC_CENTER});
                    vy_raw   <= $signed({1'b0, adc_ch2_data}) - $signed({1'b0, ADC_CENTER});
                    vsum_raw <= $signed({1'b0, adc_ch3_data}) - $signed({1'b0, ADC_CENTER});
                    
                    state <= WAIT_LUT;
                end
                
                WAIT_LUT: begin
                    // It takes 1 clock cycle for the Block RAM LUT to output data.
                    // Meanwhile, check if VSUM is large enough.
                    sum_ok <= (vsum_raw >= MIN_SUM_THRESH);
                    
                    if (vsum_raw < MIN_SUM_THRESH) begin
                        // Sum too low, zero the outputs and clear integrals
                        int_x      <= 0;
                        int_y      <= 0;
                        dac_1_data <= 16'd0;
                        dac_2_data <= 16'd0;
                        dac_valid  <= 1'b1;
                        state      <= DONE;
                    end else begin
                        state <= MULTIPLY;
                    end
                end
                
                MULTIPLY: begin
                    // LUT value is ready. Multiply to get the ratio.
                    // lut_inv_sum is an unsigned 18-bit value representing (2^38 / vsum).
                    // vx_raw is a signed 25-bit value.
                    // The result x_mult is (vx * 2^38) / vsum.
                    x_mult <= vx_raw * $signed({1'b0, lut_inv_sum});
                    y_mult <= vy_raw * $signed({1'b0, lut_inv_sum});
                    
                    state <= PID_CALC_INT;
                end
                
                PID_CALC_INT: begin
                    // We need ex_q16, which is (vx / vsum) * 2^16.
                    // x_mult is (vx / vsum) * 2^38.
                    // Therefore, we must shift right by (38 - 16) = 22.
                    ex_q16 <= x_mult >>> 22;
                    ey_q16 <= y_mult >>> 22;
                
                    // Integral X
                    next_int_x = int_x + (x_mult >>> 22);
                    if (next_int_x > INT_MAX) next_int_x = INT_MAX;
                    if (next_int_x < INT_MIN) next_int_x = INT_MIN;
                    int_x <= next_int_x;
                    
                    // Integral Y
                    next_int_y = int_y + (y_mult >>> 22);
                    if (next_int_y > INT_MAX) next_int_y = INT_MAX;
                    if (next_int_y < INT_MIN) next_int_y = INT_MIN;
                    int_y <= next_int_y;
                    
                    state <= PID_CALC_OUT;
                end
                
                PID_CALC_OUT: begin
                    // PI Calc: Kp = 5.0, Ki = 0.5 (shift right 1)
                    // next_int_x/y from previous cycle are now registered into int_x/y
                    ux_q16 <= ((x_mult >>> 22) * 5) + (int_x >>> 1);
                    uy_q16 <= ((y_mult >>> 22) * 5) + (int_y >>> 1);
                    
                    state <= SCALE_OUT_CALC;
                end
                
                SCALE_OUT_CALC: begin
                    // Convert Volts to DAC units
                    // DAC scale factor: (65535 / 130) = 504.1
                    // Apply factor and shift back from Q16 to Integer
                    // Note: dac_x_calc and dac_y_calc will infer registers here
                    // Reverted back to + (original logic)
                    dac_x_calc <= DAC_CENTER + ((ux_q16 * 504) >>> 16);
                    dac_y_calc <= DAC_CENTER + ((uy_q16 * 504) >>> 16);
                    
                    state <= SCALE_OUT_CLAMP;
                end
                
                SCALE_OUT_CLAMP: begin
                    // Clamp DAC X
                    if (dac_x_calc > 48'sd65535)
                        dac_1_data <= 16'd65535;
                    else if (dac_x_calc < 0)
                        dac_1_data <= 16'd0;
                    else
                        dac_1_data <= dac_x_calc[15:0];
                        
                    // Clamp DAC Y
                    if (dac_y_calc > 48'sd65535)
                        dac_2_data <= 16'd65535;
                    else if (dac_y_calc < 0)
                        dac_2_data <= 16'd0;
                    else
                        dac_2_data <= dac_y_calc[15:0];
                        
                    dac_valid <= 1'b1;
                    state <= DONE;
                end
                
                DONE: begin
                    // Wait for adc_ch3_valid to go low to avoid re-triggering immediately
                    if (!adc_ch3_valid) begin
                        state <= IDLE;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule
