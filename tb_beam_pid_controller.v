`timescale 1ns / 1ps

module tb_beam_pid_controller;

    reg clk;
    reg rst_n;

    reg  [23:0] adc_ch1_data;
    reg  [23:0] adc_ch2_data;
    reg  [23:0] adc_ch3_data;
    reg         adc_ch3_valid;

    wire [15:0] dac_1_data;
    wire [15:0] dac_2_data;
    wire        dac_valid;

    localparam ADC_CENTER = 24'h800000;

    //--------------------------------------------------
    // DUT
    //--------------------------------------------------

    beam_pid_controller dut (
        .clk(clk),
        .rst_n(rst_n),

        .adc_ch1_data(adc_ch1_data),
        .adc_ch2_data(adc_ch2_data),
        .adc_ch3_data(adc_ch3_data),
        .adc_ch3_valid(adc_ch3_valid),

        .dac_1_data(dac_1_data),
        .dac_2_data(dac_2_data),
        .dac_valid(dac_valid)
    );

    //--------------------------------------------------
    // 100 MHz Clock
    //--------------------------------------------------

    always #5 clk = ~clk;

    //--------------------------------------------------
    // Send Sample Task
    //--------------------------------------------------

    task send_sample;
        input [23:0] x;
        input [23:0] y;
        input [23:0] sum;
    begin

        @(posedge clk);

        adc_ch1_data  <= x;
        adc_ch2_data  <= y;
        adc_ch3_data  <= sum;
        adc_ch3_valid <= 1'b1;

        @(posedge clk);

        adc_ch3_valid <= 1'b0;

        wait(dac_valid);

        @(posedge clk);

    end
    endtask

    //--------------------------------------------------
    // Stimulus
    //--------------------------------------------------

    initial begin

        clk = 0;
        rst_n = 0;

        adc_ch1_data  = 0;
        adc_ch2_data  = 0;
        adc_ch3_data  = 0;
        adc_ch3_valid = 0;

        //--------------------------------------------------
        // Reset
        //--------------------------------------------------

        repeat(10) @(posedge clk);

        rst_n = 1;

        repeat(5) @(posedge clk);

        //--------------------------------------------------
        // Test 1 : Low Sum
        //--------------------------------------------------

        send_sample(
            ADC_CENTER,
            ADC_CENTER,
            ADC_CENTER + 24'd100000
        );

        //--------------------------------------------------
        // Test 2 : Zero Error
        //--------------------------------------------------

        send_sample(
            ADC_CENTER,
            ADC_CENTER,
            ADC_CENTER + 24'd3000000
        );

        //--------------------------------------------------
        // Test 3 : Positive X
        //--------------------------------------------------

        send_sample(
            ADC_CENTER + 24'd100000,
            ADC_CENTER,
            ADC_CENTER + 24'd3000000
        );

        //--------------------------------------------------
        // Test 4 : Negative X
        //--------------------------------------------------

        send_sample(
            ADC_CENTER - 24'd100000,
            ADC_CENTER,
            ADC_CENTER + 24'd3000000
        );

        //--------------------------------------------------
        // Test 5 : Positive Y
        //--------------------------------------------------

        send_sample(
            ADC_CENTER,
            ADC_CENTER + 24'd100000,
            ADC_CENTER + 24'd3000000
        );

        //--------------------------------------------------
        // Test 6 : Negative Y
        //--------------------------------------------------

        send_sample(
            ADC_CENTER,
            ADC_CENTER - 24'd100000,
            ADC_CENTER + 24'd3000000
        );

        //--------------------------------------------------
        // Test 7 : Integrator Build-up
        //--------------------------------------------------

        repeat(50)
        begin
            send_sample(
                ADC_CENTER + 24'd50000,
                ADC_CENTER,
                ADC_CENTER + 24'd3000000
            );
        end

        //--------------------------------------------------
        // Test 8 : Positive Saturation
        //--------------------------------------------------

        repeat(200)
        begin
            send_sample(
                ADC_CENTER + 24'd1000000,
                ADC_CENTER,
                ADC_CENTER + 24'd3000000
            );
        end

        //--------------------------------------------------
        // Test 9 : Negative Saturation
        //--------------------------------------------------

        repeat(200)
        begin
            send_sample(
                ADC_CENTER - 24'd1000000,
                ADC_CENTER,
                ADC_CENTER + 24'd3000000
            );
        end

        repeat(100) @(posedge clk);

        $finish;

    end

endmodule