// Division of the hz to 2MHz
`timescale 1ns / 1ps

module clock_divider #(
    parameter DIV_VALUE = 62 // 100MHz / 2MHz = 62.5 -> count to 62 for 1MHz SPI
) (
    input  wire clk,
    input  wire rst_n,
    output wire tick
);

    reg [15:0] count;
    
    assign tick = (count == DIV_VALUE);
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 16'd0;
        end else if (tick) begin
            count <= 16'd0;
        end else begin
            count <= count + 16'd1;
        end
    end

endmodule
