module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q
);
    always @(posedge clk ) begin
        if (reset || (q==4'b1001 && slowena)) begin
            q <= 0;
        end else begin
            q <= slowena? (q+1) : q;
        end
    end
endmodule