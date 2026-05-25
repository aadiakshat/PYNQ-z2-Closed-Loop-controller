`timescale 1ns / 1ps

module top (
    input  wire sysclk,      // 125 MHz clock on H16
    input  wire btn0,        // Reset button
    
    // PMODA Interface (JA1-JA4)
    output wire pmoda_cs_n,
    output wire pmoda_mosi,
    input  wire pmoda_miso,
    output wire pmoda_sclk,

    // LEDs for status
    output wire [3:0] led
);

    wire rst_n = ~btn0; // active low reset
    
    wire tick;
    clock_divider #(
        .DIV_VALUE(62) 
    ) clk_div_inst (
        .clk(sysclk),
        .rst_n(rst_n),
        .tick(tick)
    );

    // ==========================================
    // ADC INSTANTIATION & DEBUG
    // ==========================================
    (* mark_debug = "true" *) wire [23:0] adc_ch1_data;
    (* mark_debug = "true" *) wire        adc_ch1_valid;
    (* mark_debug = "true" *) wire [23:0] adc_ch2_data;
    (* mark_debug = "true" *) wire        adc_ch2_valid;
    (* mark_debug = "true" *) wire [23:0] adc_ch3_data;
    (* mark_debug = "true" *) wire        adc_ch3_valid;
    (* mark_debug = "true" *) wire [1:0]  current_channel;
    
    wire        spi_start;
    wire [5:0]  spi_length;
    wire [47:0] spi_data_in;
    wire [47:0] spi_data_out;
    wire        spi_busy;
    wire        spi_done;
    
    (* mark_debug = "true" *) wire [4:0]  controller_state;
    (* mark_debug = "true" *) wire dbg_spi_cs_n = pmoda_cs_n;
    (* mark_debug = "true" *) wire dbg_spi_mosi = pmoda_mosi;
    (* mark_debug = "true" *) wire dbg_spi_miso = pmoda_miso;
    (* mark_debug = "true" *) wire dbg_spi_clk  = pmoda_sclk;

    // SPI Master Debug Signals
    (* mark_debug = "true" *) wire [5:0]  dbg_bit_count    = spi_master_inst.bit_count;
    (* mark_debug = "true" *) wire [47:0] dbg_shift_reg_tx = spi_master_inst.shift_reg_tx;
    (* mark_debug = "true" *) wire [47:0] dbg_shift_reg_rx = spi_master_inst.shift_reg_rx;

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

    // ==========================================
    // LED Status Mapping
    assign led[3:0] = adc_ch1_data[23:20];

endmodule
