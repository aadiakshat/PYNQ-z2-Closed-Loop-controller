`timescale 1ns / 1ps


module pmod_da3_ctrl (
    input  wire        clk,        // System clock (e.g. 100 MHz)
    input  wire        rst_n,      // Active-low reset
    input  wire        tick,       // Clock divider tick for SPI clock rate
    
    input  wire [15:0] data_in,    // 16-bit DAC data
    input  wire        valid,      // Trigger transmission on high (1 clk pulse)
    
    output reg         cs_n,       // Chip select (active low)
    output reg         din,        // Serial data out
    output reg         ldac_n,     // Load DAC (active low)
    output reg         sclk,       // Serial clock
    
    output wire        busy        // High when transmitting
);

    localparam IDLE       = 0;
    localparam SHIFT_LOW  = 1;
    localparam SHIFT_HI   = 2;
    localparam PULSE_CS   = 3;
    localparam PULSE_LDAC = 4;
    
    reg [2:0] state;
    reg [15:0] shift_reg;
    reg [4:0] bit_cnt;

    assign busy = (state != IDLE);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            cs_n  <= 1'b1;
            din   <= 1'b0;
            ldac_n<= 1'b1;
            sclk  <= 1'b0;
            shift_reg <= 16'd0;
            bit_cnt <= 0;
        end else begin
            if (state == IDLE) begin
                cs_n  <= 1'b1;
                ldac_n<= 1'b1;
                sclk  <= 1'b0;
                
                if (valid) begin
                    shift_reg <= data_in;
                    bit_cnt   <= 5'd15;
                    state     <= SHIFT_LOW;
                end
            end else if (tick) begin
    // State transitions happen at the divided SPI clock rate
                case (state)
                    SHIFT_LOW: begin
                        cs_n  <= 1'b0;
                        sclk  <= 1'b0;
                        din   <= shift_reg[bit_cnt]; // Setup data on SCLK low
                        state <= SHIFT_HI;
                    end
                    SHIFT_HI: begin
                        sclk  <= 1'b1; // Rising edge: DAC samples data
                        if (bit_cnt == 0) begin
                            state <= PULSE_CS;
                        end else begin
                            bit_cnt <= bit_cnt - 1;
                            state   <= SHIFT_LOW;
                        end
                    end
                    PULSE_CS: begin
                        sclk  <= 1'b0;
                        cs_n  <= 1'b1; // Raise CS to complete transfer
                        state <= PULSE_LDAC;
                    end
                    PULSE_LDAC: begin
                        ldac_n<= 1'b0; // Pulse LDAC low to update DAC output
                        state <= IDLE;
                    end
                    default: state <= IDLE;
                endcase
            end else if (state == IDLE) begin
                // Ensure LDAC goes back high if we are resting in IDLE
                ldac_n <= 1'b1;
            end
        end
    end

endmodule
