module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum
);
    integer i;
    wire [3:0] count;
    assign sum[0] = x[0] ^ y[0];
    assign count[0] = x[0] & y[0];
    always @( * ) begin
        for (i = 1;i<4 ;i++ ) begin
            sum[i] = x[i] ^ y[i] ^ count[i-1];
            count[i] = (x[i]&y[i]) | (y[i]&count[i-1]) | (x[i]&count[i-1]);
        end
        sum[4] = count[3];
    end

endmodule