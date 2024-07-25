module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0] in_1 ;
    always @(posedge clk ) begin
        in_1 <= in;
        pedge <= ~in_1 & in;
    end
    
endmodule