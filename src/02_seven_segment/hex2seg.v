`timescale 1ns / 1ps

module hex2seg(
    input [3:0] hex,
    output reg [7:0] seg_data
);

always @ (*) begin
    case(hex)
        4'd0 : seg_data <= 8'b11111100 ;
        4'd1 : seg_data <= 8'b01100000 ;
        4'd2 : seg_data <= 8'b11011010 ;
        4'd3 : seg_data <= 8'b11110010 ;
        4'd4 : seg_data <= 8'b01100110 ;
        4'd5 : seg_data <= 8'b10110110 ;
        4'd6 : seg_data <= 8'b10111110 ;
        4'd7 : seg_data <= 8'b11100100 ;
        4'd8 : seg_data <= 8'b11111110 ;
        4'd9 : seg_data <= 8'b11110110 ;
        4'd10 : seg_data <= 8'b00000010 ;
        default : seg_data <= 8'b00111010; 
    endcase
end

endmodule

