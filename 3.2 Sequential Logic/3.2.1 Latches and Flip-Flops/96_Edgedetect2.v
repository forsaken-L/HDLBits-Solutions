module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] in_1;
    always @(posedge clk ) begin
        in_1 <= in;
        anyedge <= in ^ in_1;
    end

endmodule
