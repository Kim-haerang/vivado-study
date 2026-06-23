module counter_clcd (
    input clk,
    input reset_n,
    output lcd_en,
    output reg [7:0] clcd_count
    );
    
reg [13:0] delay_lcdclk;
wire tc;

    // Counterx2000 & Counterx40
    always @(posedge clk) begin
        if (reset_n == 0)
            delay_lcdclk <= 0;
        else begin
            if (delay_lcdclk < 4999)
                delay_lcdclk <=  delay_lcdclk + 1;
            else
                delay_lcdclk <= 0;
        end
    end

 // Counterx40
     always @(posedge clk) begin
        if (reset_n == 0)
            clcd_count <= 0;
        else if(tc) begin
            if (clcd_count < 40)
                clcd_count <= clcd_count + 1;
            else
                clcd_count <= 6;
        end
    end   

    assign lcd_en = ( delay_lcdclk < 4000) ? 1:0;   //(0 - 1600) / 2000
    assign tc = (delay_lcdclk == 0)? 1:0;       

endmodule
