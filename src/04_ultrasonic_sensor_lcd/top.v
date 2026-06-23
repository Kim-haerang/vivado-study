module top(
    input clk,
    input reset_n,
    input echo,
    output trig,
    output lcd_en,
    output lcd_rs,
    output lcd_rw,
    output [7:0] lcd_data
    );

wire tc;
wire [7:0] cm_100, cm_10, cm_1;
wire [7:0] clcd_count;

counter1mh counter_inst (
    .clk(clk),
    .reset_n(reset_n),
    .tc(tc)
    );
    
us_range us_range_inst (
    .clk(clk),
    .reset_n(reset_n),
    .tc(tc),
    .echo(echo),
    .trig(trig),
    .cm_100(cm_100),
    .cm_10(cm_10),
    .cm_1(cm_1)
    );    
    
decoder clcd_decoder(
    .clk(clk),
    .reset_n(reset_n),
    .cm_100(cm_100),
    .cm_10(cm_10),
    .cm_1(cm_1),
    .count_lcd(clcd_count),
    .lcd_rs(lcd_rs),
    .lcd_rw(lcd_rw),
    .lcd_data(lcd_data)
    );

counter_clcd count_clcd_inst (
    .clk(clk),
    .reset_n(reset_n),
    .lcd_en(lcd_en),
    .clcd_count(clcd_count)
    );        
    
endmodule
