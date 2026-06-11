`timescale 1ns / 1ps

module vsum_inv_lut (
    input  wire        clk,
    input  wire [10:0] index, // Top 11 bits of vsum
    output reg  [17:0] inv_sum // 18-bit multiplier
);

    // 2048 x 18-bit Block RAM
    (* rom_style = "block" *) reg [17:0] lut [0:2047];
    
    initial begin
        $readmemh("C:/Users/adars/OneDrive/Desktop/Project/vsum_inv_lut.mem", lut);
    end

    always @(posedge clk) begin
        inv_sum <= lut[index];
    end

endmodule
