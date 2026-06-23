module g2m (
    input CLK,
    input RESET,
    output UP_CLK
);

    reg [1:0] clk_count;
    
    always @ (posedge CLK, posedge RESET) begin
        if (RESET) begin
            clk_count <= 0;
        end
        else begin 
            if (clk_count < 3) clk_count <= clk_count + 1;
            else clk_count <= 0;
        end
    end
    
    assign UP_CLK = (clk_count == 0) ? 1 : 0;
    
endmodule

