module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   
);
    
  wire  wire_1,wire_2,wire_3;
  assign wire_1 = a&b;
  assign wire_2 = c&d;
  assign wire_3 = wire_1|wire_2;
  assign out = wire_3;
  assign out_n = !wire_3;

endmodule
