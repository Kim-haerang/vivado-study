`timescale 1ns / 1ps

module top(
    input clk_in,
    input reset_n,
    output [7:0] seg_out,
    output [3:0] com_out
);

wire [15:0] data;

seven_seg seven_seg_u(.clk_in(clk_in), .reset_n(reset_n), .data(data), .seg_out(seg_out), .com_out(com_out));
            
design_1_wrapper uut (.SEGDATA_0(data));

endmodule
