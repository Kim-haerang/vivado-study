module vertical(
    input CLK,
    input RESET,
    output reg [9:0] V_COUNT,
    output reg Vsync,
    output reg vDE
);

    always @ (posedge CLK or posedge RESET) begin
        if (RESET) begin
            V_COUNT <= 10'd0;
            Vsync <= 1'b0;
            vDE <= 1'b0;
        end
        else begin
            if (V_COUNT <= 10'd9) begin
                Vsync <= 1'b0;
                vDE <= 1'b0;
            end
            else if ((V_COUNT > 10'd9) && (V_COUNT <= 10'd11)) begin
                Vsync <= 1'b1;
                vDE <= 1'b0;
            end
 else if ((V_COUNT > 10'd11) && (V_COUNT <= 10'd283)) begin
                Vsync <= 1'b1;
                vDE <= 1'b1;
            end
            else if ((V_COUNT > 10'd283) && (V_COUNT <= 10'd285)) begin
                Vsync <= 1'b1;
                vDE <= 1'b0;
            end
            if (V_COUNT < 10'd285) begin
                V_COUNT <= V_COUNT + 10'd1;
            end
            else begin
                V_COUNT <= 10'd0;
            end
        end
    end

endmodule
