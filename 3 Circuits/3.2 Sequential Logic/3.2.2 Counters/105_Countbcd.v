module top_module (
    input clk,
    input reset,   
    output [3:1] ena,
    output [15:0] q
);
    assign ena = {q[11:0]==12'h999,q[7:0]==8'h99,q[3:0]==4'h9};
    
    count10 count_0(
        .clk(clk),
        .reset(reset),
        .ena(1),
        .q(q[3:0])
    );

    count10 count_1(
        .clk(clk),
        .reset(reset),
        .ena(ena[1]),
        .q(q[7:4])
    );

    count10 count_2(
        .clk(clk),
        .reset(reset),
        .ena(ena[2]),
        .q(q[11:8])
    );

    count10 count_3(
        .clk(clk),
        .reset(reset),
        .ena(ena[3]),
        .q(q[15:12])
    );

endmodule

module count10 (
    input clk,
    input reset, 
    input ena,       // Synchronous active-high reset
    output [3:0] q
);
    always @(posedge clk ) begin
        if (reset || (q==4'd1001 && ena==1)) begin
            q <= 0;
        end else begin
            q <= (ena)? q+1: q;
        end
    end
endmodule