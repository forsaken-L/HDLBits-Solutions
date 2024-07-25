module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR
);  // Q
    MUXDFF MUXDFF_0(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[0]),
        .q_in(LEDR[2]),
        .Q(LEDR[0])
    );

    MUXDFF MUXDFF_1(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[1]),
        .q_in(LEDR[0]),
        .Q(LEDR[1])
    );

    MUXDFF MUXDFF_2(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[2]),
        .q_in(LEDR[2]^LEDR[1]),
        .Q(LEDR[2])
    );

endmodule

module MUXDFF (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q
);
    always @(posedge clk ) begin
        Q <= L? r_in: q_in;
    end
    
endmodule