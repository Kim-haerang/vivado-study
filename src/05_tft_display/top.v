module top(
    input clk,
    input reset_n,
    input SW,
    output TCLK,
    output reg Hsync,
    output reg Vsync,
    output DE,          // TFT-LCD Data enable
    output [7:3] R,
    output [7:2] G,
    output [7:3] B,
    output Tpower       // TFT-LCD Backlight
);

    wire BRAMCLK;
    wire [16:0] BRAMADDRA;
    wire [15:0] BRAMDATA;
    wire g2mclk;
    wire hclk;
    wire [9:0] H_COUNT;
    wire [9:0] V_COUNT;
    wire hDE;
    wire vDE;
    wire DEimage;
    wire RESET;
    wire Hsyncimage;
    wire Vsyncimage;    

    wire [7:3] BRAM_R;
    wire [7:2] BRAM_G;
    wire [7:3] BRAM_B;
    wire [7:3] BAR_R;
    wire [7:2] BAR_G;
    wire [7:3] BAR_B;

    assign RESET = ~reset_n;
    assign Tpower = 1;
    assign TCLK = g2mclk;
    assign DE = 1'b1;
    assign DEimage = hDE & vDE;
   
    always @ (posedge g2mclk, posedge RESET) begin
        if (RESET) begin
            Vsync <= 1'b0;
            Hsync <= 1'b0;
        end
        else begin
            Vsync <= Vsyncimage;
            Hsync <= Hsyncimage;
        end
    end
 // TFT-LCD Clock
    g2m a_g2m (
        .CLK(clk),
        .UP_CLK(g2mclk),
        .RESET(RESET)
    );
    
    horizontal b_horizontal (
        .CLK(g2mclk),
        .UP_CLKa(hclk),
        .H_COUNT(H_COUNT),
        .Hsync(Hsyncimage),
        .hDE(hDE),
        .RESET(RESET)
    );

    vertical c_vertical (
        .CLK(hclk),
        .V_COUNT(V_COUNT),
        .Vsync(Vsyncimage),
        .vDE(vDE),
        .RESET(RESET)
    );
    
 rgb d_rgb (
        .clk(g2mclk),
        .RESET(RESET),
        .DE(DEimage),
        .R(BAR_R),
        .G(BAR_G),
        .B(BAR_B),
        .H_COUNT(H_COUNT),
        .V_COUNT(V_COUNT)
    );

    // BRAM Controller
    BRAMCtrl f_BRAMCtrl
    (
        .CLK(g2mclk),
        .RESET(RESET),
        .Vsync(Vsyncimage),
        .Hsync(Hsyncimage),
        .DE(DEimage),
        .BRAMCLK(BRAMCLK),
        .BRAMADDR(BRAMADDRA),
        .BRAMDATA(BRAMDATA),
        .R(BRAM_R),
        .G(BRAM_G),
        .B(BRAM_B),
        .Reverse_SW(1'b0)
    );

      bufferram bufferram_i (
      .clka( clk ),
      .ena(1'b1),
      .wea( 1'b0 ),
      .addra( BRAMADDRA ),
      .dina( 15'd0 ),
      .douta( BRAMDATA )
      );
 
    assign R = (SW) ? BRAM_R : BAR_R;
    assign G = (SW) ? BRAM_G : BAR_G;
    assign B = (SW) ? BRAM_B : BAR_B;

endmodule
