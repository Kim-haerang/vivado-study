module counter1mh(
    input clk,
    input reset_n,
    output tc
    );
    
    reg [7:0] count;
    
    always @ (posedge clk, negedge reset_n) begin
        if (!reset_n)   
            count <=0;
        else begin
            if (count < 99) count <= count + 1;
            else count <= 0;
         end
     end
     
     assign tc = (count == 0) ? 1 : 0;   
          
endmodule

