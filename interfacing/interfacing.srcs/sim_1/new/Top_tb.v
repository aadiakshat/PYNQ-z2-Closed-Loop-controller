`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.06.2026 10:53:57
// Design Name: 
// Module Name: Top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:`timescale 1ns/1ps

module tb_beam_pid;

    reg clk;
    reg rst_n;

    reg  [23:0] adc_ch1_data;
    reg  [23:0] adc_ch2_data;
    reg  [23:0] adc_ch3_data;
    reg         adc_ch3_valid;

    wire [15:0] dac_1_data;
    wire [15:0] dac_2_data;
    wire        dac_valid;

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

    //------------------------------------------
    // Clock
    //------------------------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 100 MHz
    end

    //------------------------------------------
    // Stimulus
    //------------------------------------------
    initial begin

        rst_n = 0;
        adc_ch1_data = 0;
        adc_ch2_data = 0;
        adc_ch3_data = 0;
        adc_ch3_valid = 0;

        #100;
        rst_n = 1;

        //--------------------------------------
        // Test Vector
        //--------------------------------------
        //
        // X   = +6.5
        // Y   = -2.5
        // SUM = +14.4
        //
        // Convert to AD7193 bipolar:
        // code = 0x800000 + value*(8388607/15)
        //
        //--------------------------------------

        adc_ch1_data = 24'hB77777;   // approx +6.5
        adc_ch2_data = 24'h6AAAAA;   // approx -2.5
        adc_ch3_data = 24'hF5C28F;   // approx +14.4

        @(posedge clk);
        adc_ch3_valid = 1'b1;

        @(posedge clk);
        adc_ch3_valid = 1'b0;

        wait(dac_valid);

        $display("------------------------------------------------");
        $display("DAC1 = %d", dac_1_data);
        $display("DAC2 = %d", dac_2_data);
        $display("------------------------------------------------");

        #10000;

        $finish;
    end

endmodule
// 
//////////////////////////////////////////////////////////////////////////////////


module Top_tb(

    );
endmodule
