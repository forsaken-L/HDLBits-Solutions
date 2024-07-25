module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_1;
    always @(posedge clk ) begin
        in_1 <= in;
        if (reset) begin
            out <= 0;
        end else begin
            out <= out | (~in & in_1);
        end
    end
    
endmodule
