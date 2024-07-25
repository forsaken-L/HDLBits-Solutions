module top_module( 
    input [2:0] in,
    output [1:0] out 
);
    
    always @( * ) begin
        out = 0;
        for (integer i = 0 ;i<3 ;i++ ) begin
            if (in[i]) begin
                out = out+1;
            end else begin
                out = out;
            end
        end
    end
endmodule
