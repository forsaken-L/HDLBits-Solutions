module top_module (
    input clk,
    input a,
    output [3:0] q 
);
    always @(posedge clk ) begin
        if (a) begin
            q<= 4;
        end else begin
            if (q<6) begin
                q<= q+1;
            end else begin
                q<= 0;
            end
        end
    end

endmodule
