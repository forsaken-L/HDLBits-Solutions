module top_module (
    input clk,
    input d,
    output q
);
    reg q_posedge, q_negedge;

    always @(posedge clk ) begin
        q_posedge <= d;
    end
    
    always @(negedge clk ) begin
        q_negedge <= d;
    end
    
    assign q = clk? q_posedge: q_negedge;
    
endmodule
