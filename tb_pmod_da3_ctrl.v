`timescale 1ns / 1ps

module tb_pmod_da3_ctrl();

    reg clk;
    reg rst_n;
    reg tick;
    
    reg [15:0] data_in;
    reg valid;
    
    wire cs_n;
    wire din;
    wire ldac_n;
    wire sclk;
    wire busy;

    // Instantiate the DAC controller
    pmod_da3_ctrl uut (
        .clk(clk),
        .rst_n(rst_n),
        .tick(tick),
        .data_in(data_in),
        .valid(valid),
        .cs_n(cs_n),
        .din(din),
        .ldac_n(ldac_n),
        .sclk(sclk),
        .busy(busy)
    );

    // 125 MHz Clock generation
    initial clk = 0;
    always #4 clk = ~clk;

    // Tick generation (e.g. div by 10 for simulation speed)
    reg [3:0] tick_div;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tick_div <= 0;
            tick <= 0;
        end else begin
            if (tick_div == 9) begin
                tick_div <= 0;
                tick <= 1;
            end else begin
                tick_div <= tick_div + 1;
                tick <= 0;
            end
        end
    end

    // Test stimulus
    initial begin
        // Initialize inputs
        rst_n = 0;
        data_in = 16'h0000;
        valid = 0;

        // Reset
        #100;
        rst_n = 1;
        #100;

        // Simulate ADC CH1 providing data
        @(posedge clk);
        data_in = 16'hA5A5;
        valid = 1;
        @(posedge clk);
        valid = 0;

        // Wait for DAC transfer to complete
        wait(busy == 0);
        #200;

        // Simulate ADC CH2 providing data
        @(posedge clk);
        data_in = 16'h1234;
        valid = 1;
        @(posedge clk);
        valid = 0;
        
        wait(busy == 0);
        #500;
        
        $display("Simulation completed successfully.");
        $finish;
    end

endmodule
