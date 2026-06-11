`timescale 1ns / 1ps

module top (
    input  wire sysclk,      // 100 MHz clock on H16
    input  wire btn0,        // Reset button
    input  wire btn2,        //Mode switching button
    
    // PMODA Interface
    output wire pmoda_cs_n,
    output wire pmoda_mosi,
    input  wire pmoda_miso,
    output wire pmoda_sclk,

    // LEDs to check if yhe values are coming or not
     output wire [3:0] led,
    // PMODB Interface (Pmod DA3 DACs)
    // DAC A (ADC CH1)
    output wire pmodb_pin1,  // CS_N
    output wire pmodb_pin2,  // DIN
    output wire pmodb_pin3,  // LDAC_N
    output wire pmodb_pin4,  // SCLK
    output wire pmodb_pin7,  // CS_N
    output wire pmodb_pin8,  // DIN
    output wire pmodb_pin9,  // LDAC_N
    output wire pmodb_pin10  // SCLK
);

    wire rst_n = ~btn0; // active low reset
    
    //dividing clock from 100Mhz to lower value in order for ADC to function
    wire tick;
    clock_divider #(
        .DIV_VALUE(62) 
    ) clk_div_inst (
        .clk(sysclk),
        .rst_n(rst_n),
        .tick(tick)
    );
    
     wire [23:0] adc_ch1_data;
     wire        adc_ch1_valid;
     wire [23:0] adc_ch2_data;
     wire        adc_ch2_valid;
     wire [23:0] adc_ch3_data;
     wire        adc_ch3_valid;
     wire [1:0]  current_channel;
    
    wire        spi_start;
    wire [5:0]  spi_length;
    wire [47:0] spi_data_in;
    wire [47:0] spi_data_out;
    wire        spi_busy;
    wire        spi_done;
    
     wire [4:0]  controller_state;
     // debug lines for ILA no meaning in wiring, can be commented out if you want
     wire dbg_spi_cs_n = pmoda_cs_n;
     wire dbg_spi_mosi = pmoda_mosi;
     wire dbg_spi_miso = pmoda_miso;
     wire dbg_spi_clk  = pmoda_sclk;

    // SPI Master Debug Signals for ILA ,can also be commented out
     wire [5:0]  dbg_bit_count    = spi_master_inst.bit_count;
     wire [47:0] dbg_shift_reg_tx = spi_master_inst.shift_reg_tx;
     wire [47:0] dbg_shift_reg_rx = spi_master_inst.shift_reg_rx;

    ad7193_controller adc_ctrl (
        .clk(sysclk),
        .rst_n(rst_n),
        .adc_ch1_data(adc_ch1_data),
        .adc_ch1_valid(adc_ch1_valid),
        .adc_ch2_data(adc_ch2_data),
        .adc_ch2_valid(adc_ch2_valid),
        .adc_ch3_data(adc_ch3_data),
        .adc_ch3_valid(adc_ch3_valid),
        .current_channel(current_channel),
        .spi_start(spi_start),
        .spi_transfer_length(spi_length),
        .spi_data_in(spi_data_in),
        .spi_data_out(spi_data_out),
        .spi_busy(spi_busy),
        .spi_done(spi_done),
        .spi_cs_n(pmoda_cs_n),
        .spi_miso(pmoda_miso),
        .state_out(controller_state)
    );

    spi_master #(
        .MAX_TRANSFER_BITS(48)
    ) spi_master_inst (
        .clk(sysclk),
        .rst_n(rst_n),
        .tick(tick),
        .start(spi_start),
        .transfer_length(spi_length),
        .data_in(spi_data_in),
        .data_out(spi_data_out),
        .busy(spi_busy),
        .done(spi_done),
        .spi_clk(pmoda_sclk),
        .spi_mosi(pmoda_mosi),
        .spi_miso(pmoda_miso)
    );
    
    // LED Status Mapping,starting 4 bits of data
    assign led[3:0] = adc_ch1_data[23:20];
    
    wire [15:0] dac_1_data;
    wire [15:0] dac_2_data;
    wire        pid_dac_valid;

    //two flop synchronizer to avoid metastability
    reg btn2_sync_1;
    reg btn2_sync_2;
    always @(posedge sysclk or negedge rst_n) begin
        if (!rst_n) begin
            btn2_sync_1 <= 1'b0;
            btn2_sync_2 <= 1'b0;
        end else begin
            btn2_sync_1 <= btn2;
            btn2_sync_2 <= btn2_sync_1;
        end
    end
    wire test_mode_en = btn2_sync_2;

    // Dynamic test values from Vitis (via AXI GPIO)
    wire [15:0] dac_x_test_val_ps;
    wire [15:0] dac_y_test_val_ps;
    
    // Instantiate the Zynq PS Block Design wrapper
    system_wrapper ps_system (
        .dac_x_out (dac_x_test_val_ps),
        .dac_y_out (dac_y_test_val_ps),
        .adc_x_in  (test_mode_en ? {16'd0, dac_x_test_val_ps} : {8'd0, adc_ch1_data}), // Loopback in test mode
        .adc_y_in  (test_mode_en ? {16'd0, dac_y_test_val_ps} : {8'd0, adc_ch2_data})  // Loopback in test mode
    );

    wire [15:0] dac_1_muxed = test_mode_en ? dac_x_test_val_ps : dac_1_data;
    wire [15:0] dac_2_muxed = test_mode_en ? dac_y_test_val_ps : dac_2_data;

    wire dac_1_busy;
    wire dac_2_busy;
    wire dac_1_valid = test_mode_en ? ~dac_1_busy : pid_dac_valid;
    wire dac_2_valid = test_mode_en ? ~dac_2_busy : pid_dac_valid;

    beam_pid_controller pid_inst (
        .clk(sysclk),
        .rst_n(rst_n),
        .adc_ch1_data(adc_ch1_data),
        .adc_ch2_data(adc_ch2_data),
        .adc_ch3_data(adc_ch3_data),
        .adc_ch3_valid(adc_ch3_valid),
        .dac_1_data(dac_1_data),
        .dac_2_data(dac_2_data),
        .dac_valid(pid_dac_valid)
    );

    pmod_da3_ctrl dac_ctrl_a (
        .clk(sysclk),
        .rst_n(rst_n),
        .tick(tick),
        .data_in(dac_1_muxed),
        .valid(dac_1_valid),
        .cs_n(pmodb_pin1),
        .din(pmodb_pin2),
        .ldac_n(pmodb_pin3),
        .sclk(pmodb_pin4),
        .busy(dac_1_busy)
    );

    pmod_da3_ctrl dac_ctrl_b (
        .clk(sysclk),
        .rst_n(rst_n),
        .tick(tick),
        .data_in(dac_2_muxed),
        .valid(dac_2_valid),
        .cs_n(pmodb_pin7),
        .din(pmodb_pin8),
        .ldac_n(pmodb_pin9),
        .sclk(pmodb_pin10),
        .busy(dac_2_busy)
    );

endmodule
