module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum 
);
    integer i;
    assign cout[0] = (a[0]&b[0]) | (b[0]&cin) | (a[0]&cin);
    assign sum[0] = a[0] ^ b[0] ^ cin;
    always @( * ) begin
        for (i =1 ;i<3 ;i++ ) begin
            cout[i] = (a[i]&b[i]) | (b[i]&cout[i-1]) | (a[i]&cout[i-1]);
            sum[i] = a[i] ^ b[i] ^ cout[i-1];
        end
    end

endmodule