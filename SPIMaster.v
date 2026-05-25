`timescale 1ns / 1ps

module spi_master #(
    parameter MAX_TRANSFER_BITS = 48
) (
    input  wire                              clk,
    input  wire                              rst_n,
    input  wire                              tick,
    input  wire                              start,
    input  wire [5:0]                        transfer_length,
    input  wire [MAX_TRANSFER_BITS-1:0]      data_in,
    output reg  [MAX_TRANSFER_BITS-1:0]      data_out,
    output reg                               busy,
    output reg                               done,
    
    // SPI physical interface
    output reg                               spi_clk,
    output reg                               spi_mosi,
    input  wire                              spi_miso,
    
    // ILA Debug signals
    output wire [5:0]                        dbg_bit_count,
    output wire [MAX_TRANSFER_BITS-1:0]      dbg_shift_reg_tx,
    output wire [MAX_TRANSFER_BITS-1:0]      dbg_shift_reg_rx
);

    localparam IDLE         = 2'd0;
    localparam FALLING_EDGE = 2'd1;
    localparam RISING_EDGE  = 2'd2;
    localparam DONE         = 2'd3;

    reg [1:0] state;
    reg [5:0] bit_count;
    reg [MAX_TRANSFER_BITS-1:0] shift_reg_tx;
    reg [MAX_TRANSFER_BITS-1:0] shift_reg_rx;

    assign dbg_bit_count    = bit_count;
    assign dbg_shift_reg_tx = shift_reg_tx;
    assign dbg_shift_reg_rx = shift_reg_rx;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state        <= IDLE;
            busy         <= 1'b0;
            done         <= 1'b0;
            spi_clk      <= 1'b1; // CPOL = 1, idle high
            spi_mosi     <= 1'b1; // idle high
            data_out     <= 0;
            bit_count    <= 6'd0;
            shift_reg_tx <= 0;
            shift_reg_rx <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    spi_clk <= 1'b1;
                    if (start) begin
                        busy         <= 1'b1;
                        shift_reg_tx <= data_in;
                        bit_count    <= transfer_length;
                        state        <= FALLING_EDGE;
                    end
                end

                FALLING_EDGE: begin
                    if (tick) begin
                        spi_clk <= 1'b0; // CPOL=1, first edge is falling
                        // CPHA=1: Drive MOSI on the first edge (falling)
                        spi_mosi <= shift_reg_tx[MAX_TRANSFER_BITS-1]; 
                        state <= RISING_EDGE;
                    end
                end

                RISING_EDGE: begin
                    if (tick) begin
                        spi_clk <= 1'b1; // CPOL=1, second edge is rising
                        // CPHA=1: Sample MISO on the second edge (rising)
                        shift_reg_rx <= {shift_reg_rx[MAX_TRANSFER_BITS-2:0], spi_miso};
                        shift_reg_tx <= {shift_reg_tx[MAX_TRANSFER_BITS-2:0], 1'b0};
                        
                        if (bit_count == 6'd1) begin
                            state <= DONE;
                        end else begin
                            bit_count <= bit_count - 6'd1;
                            state <= FALLING_EDGE;
                        end
                    end
                end

                DONE: begin
                    busy <= 1'b0;
                    done <= 1'b1;
                    // For shift left, the received bits are naturally LSB aligned 
                    // after transfer_length shifts.
                    data_out <= shift_reg_rx;
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end

endmodule
