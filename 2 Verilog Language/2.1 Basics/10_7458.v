module top_module (
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y 
);
    
  wire wire_1abc, wire_1def, wire_2ab, wire_2cd;

  assign wire_1abc = p1a & p1b & p1c;
  assign wire_1def = p1d & p1e & p1f;
  assign p1y = wire_1abc | wire_1def;

  assign wire_2ab = p2a & p2b;
  assign wire_2cd = p2c & p2d;
  assign p2y = wire_2ab | wire_2cd;


endmodule
