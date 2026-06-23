`timescale 1ns / 1ps

module decoder(
    input clk,
    input reset_n,
    input [7:0] count_lcd,
    input [7:0] cm_100,
    input [7:0] cm_10,
    input [7:0] cm_1,
    output lcd_rs,
    output lcd_rw,
    output [7:0] lcd_data
    );

localparam lcd_blank = 8'b00100000, lcd_dash = 8'b00101101, lcd_colon = 8'b00111010, lcd_comma = 8'b00101100, lcd_Dot = 8'b00101110,
           lcd_0 = 8'b00110000, lcd_1 = 8'b00110001, lcd_2 = 8'b00110010, lcd_3 = 8'b00110011, lcd_4 = 8'b00110100,
           lcd_5 = 8'b00110101, lcd_6 = 8'b00110110, lcd_7 = 8'b00110111, lcd_8 = 8'b00111000, lcd_9 = 8'b00111001,
           lcd_a = 8'b01000001, lcd_b = 8'b01000010, lcd_c = 8'b01000011, lcd_d = 8'b01000100, lcd_e = 8'b01000101,
           lcd_f = 8'b01000110, lcd_g = 8'b01000111, lcd_h = 8'b01001000, lcd_i = 8'b01001001, lcd_j = 8'b01001010,
           lcd_k = 8'b01001011, lcd_l = 8'b01001100, lcd_m = 8'b01001101, lcd_n = 8'b01001110, lcd_o = 8'b01001111,
           lcd_p = 8'b01010000, lcd_q = 8'b01010001, lcd_r = 8'b01010010, lcd_s = 8'b01010011, lcd_t = 8'b01010100,
           lcd_u = 8'b01010101, lcd_v = 8'b01010110, lcd_w = 8'b01010111, lcd_x = 8'b01011000, lcd_y = 8'b01011001,
           lcd_z = 8'b01011010, lcd_under = 8'b01011111, lcd_s_a = 8'b01100001, lcd_s_b = 8'b01100010, lcd_s_c = 8'b01100011,
           lcd_s_d = 8'b01100100, lcd_s_e = 8'b01100101, lcd_s_f = 8'b01100110, lcd_s_g = 8'b01100111, lcd_s_h = 8'b01101000,
           lcd_s_i = 8'b01101001, lcd_s_j = 8'b01101010, lcd_s_k = 8'b01101011, lcd_s_l = 8'b01101100, lcd_s_m = 8'b01101101,
           lcd_s_n = 8'b01101110, lcd_s_o = 8'b01101111, lcd_s_p = 8'b01110000, lcd_s_q = 8'b01110001, lcd_s_r = 8'b01110010,
           lcd_s_s = 8'b01110011, lcd_s_t = 8'b01110100, lcd_s_u = 8'b01110101, lcd_s_v = 8'b01110110, lcd_s_w = 8'b01110111,
           lcd_s_x = 8'b01111000, lcd_s_y = 8'b01111001, lcd_s_z = 8'b01111010,
           add_line_1 = 8'b10000000, add_line_2 = 8'b11000000, add_line_3 = 8'b10010100, add_line_4 = 8'b11010100;

localparam MODE_PWR_ON = 4'd1,     //power on
           MODE_FN_SET = 4'd2,     //function set
           MODE_ONOFF = 4'd3,      //display on/off control
           MODE_ENTR_1 = 4'd4,
           MODE_ENTR_2 = 4'd5,
           MODE_ENTR_3 = 4'd6,
           MODE_SET_ADDR_1 = 4'd7, //set addr 1st line
           MODE_WR_1 = 4'd8,       //write 1st line
           MODE_SET_ADDR_2 = 4'd9, //set addr 2nd line
           MODE_WR_2 = 4'd10,      //wirte 2nd line
           MODE_DELAY = 4'd11,     //delay
           MODE_ACTCMD = 4'd12;    //user command 

wire [31:0] reg_a;
wire [31:0] reg_b;
wire [31:0] reg_c;
wire [31:0] reg_d;
wire [31:0] reg_e;
wire [31:0] reg_f;
wire [31:0] reg_g;
wire [31:0] reg_h;

reg  [4:0] lcd_mode = 0;
reg [9:0] set_data;

assign reg_a = {lcd_blank, lcd_blank, lcd_s, lcd_s_o	} ; 
assign reg_b = {lcd_s_n, lcd_s_i, lcd_s_c, lcd_blank	} ; 
assign reg_c = {lcd_r, lcd_s_a, lcd_s_n, lcd_s_g	} ;
assign reg_d = {lcd_s_e, lcd_colon, lcd_blank, lcd_blank} ; 
assign reg_e = {lcd_d, lcd_s_i, lcd_s_s, lcd_s_t} ; 
assign reg_f = {lcd_s_a, lcd_s_n, lcd_s_c, lcd_s_e };
assign reg_g = {lcd_colon, lcd_blank, cm_100, cm_10};
assign reg_h = {cm_1, lcd_blank, lcd_s_c, lcd_s_m	} ;  


// decoder switch
always @(posedge clk) begin
	if (reset_n == 0)
		lcd_mode <= MODE_PWR_ON;
    else begin
        case (count_lcd)
            0  : lcd_mode <= MODE_PWR_ON ;
            1  : lcd_mode <= MODE_FN_SET ;
            2  : lcd_mode <= MODE_ONOFF ;
            3  : lcd_mode <= MODE_ENTR_1 ;
            4  : lcd_mode <= MODE_ENTR_2 ;
            5  : lcd_mode <= MODE_ENTR_3 ;
            6  : lcd_mode <= MODE_SET_ADDR_1 ;
            7  : lcd_mode <= MODE_WR_1 ;
            23 : lcd_mode <= MODE_SET_ADDR_2 ;
            24 : lcd_mode <= MODE_WR_2 ;
            40 : lcd_mode <= MODE_DELAY ;
            41 : lcd_mode <= MODE_ACTCMD ;
            default : begin end 
        endcase    
	end
end

assign lcd_rs = set_data[9];
assign lcd_rw = set_data[8];
assign lcd_data = set_data[7:0];

// decoder output
always @(posedge clk)
begin 
	if (reset_n == 0)
		set_data = 10'b0000000000;
	else begin
		case (lcd_mode)
		    MODE_PWR_ON : set_data = {2'b00, 8'h38};
		    MODE_FN_SET : set_data = {2'b00, 8'h38};
		    MODE_ONOFF : set_data = {2'b00, 8'h0e};
		    MODE_ENTR_1 : set_data = {2'b00, 8'h06};
		    MODE_ENTR_2 : set_data = {2'b00, 8'h02};
		    MODE_ENTR_3 : set_data = {2'b00, 8'h01};			    
		    MODE_SET_ADDR_1 : set_data = {2'b00, 8'h80};
		    MODE_WR_1 : begin 
                case (count_lcd)
                     7 : set_data = {1'b1, 1'b0, reg_a[31:24]};
                     8 : set_data = {1'b1, 1'b0, reg_a[23:16]};
                     9 : set_data = {1'b1, 1'b0, reg_a[15: 8]}; 
                    10 : set_data = {1'b1, 1'b0, reg_a[7 : 0]}; 
                    11 : set_data = {1'b1, 1'b0, reg_b[31:24]};
                    12 : set_data = {1'b1, 1'b0, reg_b[23:16]};
                    13 : set_data = {1'b1, 1'b0, reg_b[15: 8]}; 
                    14 : set_data = {1'b1, 1'b0, reg_b[7 : 0]}; 
                    15 : set_data = {1'b1, 1'b0, reg_c[31:24]};
                    16 : set_data = {1'b1, 1'b0, reg_c[23:16]};
                    17 : set_data = {1'b1, 1'b0, reg_c[15: 8]}; 
                    18 : set_data = {1'b1, 1'b0, reg_c[7 : 0]}; 
                    19 : set_data = {1'b1, 1'b0, reg_d[31:24]};
                    20 : set_data = {1'b1, 1'b0, reg_d[23:16]};
                    21 : set_data = {1'b1, 1'b0, reg_d[15: 8]};
                    22 : set_data = {1'b1, 1'b0, reg_d[7 : 0]};
                endcase
           end
		   MODE_SET_ADDR_2 : set_data = {2'b00, 8'hc0};
		   MODE_WR_2 : begin
               case (count_lcd)
                    24 : set_data = {1'b1, 1'b0, reg_e[31:24]};
                    25 : set_data = {1'b1, 1'b0, reg_e[23:16]};
                    26 : set_data = {1'b1, 1'b0, reg_e[15: 8]}; 
                    27 : set_data = {1'b1, 1'b0, reg_e[7 : 0]}; 
                    28 : set_data = {1'b1, 1'b0, reg_f[31:24]};
                    29 : set_data = {1'b1, 1'b0, reg_f[23:16]};
                    30 : set_data = {1'b1, 1'b0, reg_f[15: 8]}; 
                    31 : set_data = {1'b1, 1'b0, reg_f[7 : 0]}; 
                    32 : set_data = {1'b1, 1'b0, reg_g[31:24]};
                    33 : set_data = {1'b1, 1'b0, reg_g[23:16]};
                    34 : set_data = {1'b1, 1'b0, reg_g[15: 8]}; 
                    35 : set_data = {1'b1, 1'b0, reg_g[7 : 0]}; 
                    36 : set_data = {1'b1, 1'b0, reg_h[31:24]};
                    37 : set_data = {1'b1, 1'b0, reg_h[23:16]};
                    38 : set_data = {1'b1, 1'b0, reg_h[15: 8]};
                    39 : set_data = {1'b1, 1'b0, reg_h[7 : 0]};
               endcase
	    	end
		    MODE_DELAY : set_data = {2'b00, 8'h02};
		    MODE_ACTCMD : set_data = {2'b00, 8'h02};
		    default : begin end
		endcase
	end
end 
endmodule



