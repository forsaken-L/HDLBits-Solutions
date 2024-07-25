module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out
);
    reg [2:0] q;
    always @(posedge clk ) begin
        if (~resetn) begin
            {out,q[2:0]} <= 0;
        end else begin
            {out, q[2:0]} <= {q[2:0], in};
        end
    end

endmodule