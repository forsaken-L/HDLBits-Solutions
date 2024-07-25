module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    parameter s000 = 3'b000, s001 = 3'b001, s010 = 3'b010, s011 = 3'b011, s100 = 3'b100;
    reg [2:0] Y;

    always @( * ) begin
        case (y)
            s000: Y = x? s001: s000;
            s001: Y = x? s100: s001;
            s010: Y = x? s001: s010;
            s011: Y = x? s010: s001;
            s100: Y = x? s100: s011; 
        endcase
    end

    assign z = (y==s011)||(y==s100);
    assign Y0 = Y[0];

endmodule
