module horizontal(
    input CLK,
    input RESET,
    output UP_CLKa,
    output reg [9:0] H_COUNT,
    output reg Hsync,
    output reg hDE
);
    assign UP_CLKa = ~Hsync;
    
    always @ (posedge CLK or posedge RESET) begin
        if (RESET) begin
            Hsync <= 1'b0;
            H_COUNT <= 10'd0;
            hDE <= 1'b0;
            //UP_CLKa <= 1'b0;
        end
        else begin
            //UP_CLKa = ~Hsync;
            if (H_COUNT <= 10'd40) begin
                Hsync <= 1'b0;
                hDE <= 1'b0;
            end
            else if ((H_COUNT > 10'd40) && (H_COUNT <= 10'd42)) begin
                Hsync <= 1'b1;
                hDE <= 1'b0;
            end
            else if ((H_COUNT > 10'd42) && (H_COUNT <= 10'd522)) begin
                Hsync <= 1'b1;
                hDE <= 1'b1;
            end
            else if ((H_COUNT > 10'd522) && (H_COUNT <= 10'd524)) begin
                Hsync <= 1'b1;
                hDE <= 1'b0;
            end
            
            if (H_COUNT < 10'd524) begin
                H_COUNT <= H_COUNT + 10'd1;
            end
            else begin
                H_COUNT <= 10'd0;
            end    
        end
    end
    
endmodule
