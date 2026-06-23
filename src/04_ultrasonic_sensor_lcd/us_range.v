module us_range(
    input clk,
    input reset_n,
    input echo,
    input tc, // 1us signal
    output reg trig,
    output [7:0] cm_100,
    output [7:0] cm_10,
    output [7:0] cm_1
    );
    
    parameter TRIGGER = 4'b0001,
                ECHO = 4'b0010,
                WAIT = 4'b0100;
    
    reg [15:0] count;
    reg [3:0] status;
    reg [15:0] echo_pulse;
    wire [15:0] range_cm;
    always @ (posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            status <= WAIT;
            count <= 16'd0;
        end
        else begin

        if (tc) begin
            count <= count + 1;
            case (status)
                WAIT: begin
                    trig <= 1'b0;
                    if(count > 9999) status <= TRIGGER;  // 10ms
                end
                TRIGGER: begin
                    trig <= 1'b1;
                    echo_pulse <= 16'd0;
                    if (count > 10009) status <= ECHO;   // 10us
                end
                ECHO: begin
                    trig <= 1'b0;
                    if (echo) echo_pulse <= echo_pulse + 1;
                    if (count > 59999) begin  // ~50ms
                        count <= 16'd0;
                        status <= WAIT;
                     end
                 end
             endcase
         end
     end
     end
     
     assign range_cm = echo_pulse / 58;   // cm
     assign cm_100 = (range_cm / 100) + 48;  // Ascii
     assign cm_10 = ((range_cm / 10) % 10) + 48;
     assign cm_1 = (range_cm % 10) + 48;        
    
endmodule
