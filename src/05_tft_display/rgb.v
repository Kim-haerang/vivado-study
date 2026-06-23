module rgb(
    input clk,
    input RESET,
    input DE,
    input [9:0] H_COUNT,
    input [9:0] V_COUNT,
    output reg [7:3] R,
    output reg [7:2] G,
    output reg [7:3] B
);

    always @ (posedge clk) begin
        if (RESET == 1) begin
            R <= 5'b0;
            G <= 6'b0;
            B <= 5'b0;
        end
        else if (DE == 1) begin
            if (H_COUNT >= 10'd1) begin
                if ((V_COUNT > 10'd11) && (V_COUNT <= 10'd45)) begin
                    R <= 5'b11111;
                    G <= 6'b111111;
                    B <= 5'b11111;
                end
                else if ((V_COUNT > 10'd45) && (V_COUNT <= 10'd79)) begin
                    R <= 5'b11111;
                    G <= 6'b111111;
                    B <= 5'b0;
                end
                else if ((V_COUNT > 10'd79) && (V_COUNT <= 10'd113)) begin
                    R <= 5'b0;
                    G <= 6'b111111;
                    B <= 5'b11111;
                end
                else if ((V_COUNT > 10'd113) && (V_COUNT <= 10'd147)) begin
                    R <= 5'b0;
                    G <= 6'b111111;
                    B <= 5'b0;
                end
                else if ((V_COUNT > 10'd147) && (V_COUNT <= 10'd181)) begin
                    R <= 5'b11111;
                    G <= 6'b0;
                    B <= 5'b11111;
                end
                else if ((V_COUNT > 10'd181) && (V_COUNT <= 10'd215)) begin
                    R <= 5'b11111;
                    G <= 6'b0;
                    B <= 5'b0;
                end
                else if ((V_COUNT > 10'd215) && (V_COUNT <= 10'd249)) begin
                    R <= 5'b0;
                    G <= 6'b0;
                    B <= 5'b11111;
                end
                else begin
                    R <= 5'b0;
                    G <= 6'b0;
                    B <= 5'b0;
                end
            end
            else begin 
                R <= 5'b0;
                G <= 6'b0;
                B <= 5'b0;
            end
        end
    end	
    
endmodule
