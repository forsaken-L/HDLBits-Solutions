module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); 
    wire [11:0] Q;
    assign c_enable[0] = 4'b1;
    assign c_enable[1] = (Q[3:0] == 4'h9);
    assign c_enable[2] = (Q[7:0] == 8'h99);
    assign OneHertz = (Q[11:0] == 12'h999);

    bcdcount counter0 (clk, reset, c_enable[0], Q[3:0]);
    bcdcount counter1 (clk, reset, c_enable[1], Q[7:4]);
    bcdcount counter2 (clk, reset, c_enable[2], Q[11:8]);
endmodule