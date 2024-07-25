module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum 
);

    wire [99:0]cout_temp;

    bcd_fadd instance1(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(cout_temp[0]),
        .sum(sum[3:0])
    );

    generate
        genvar i;
        for (i= 1;i<100 ; i++) begin :add1
            bcd_fadd instance1(
                .a(a[i*4+3:i*4]),
                .b(b[i*4+3:i*4]),
                .cin(cout_temp[i-1]),
                .cout(cout_temp[i]),
                .sum(sum[i*4+3:i*4])
            );
            
        end

    endgenerate
    
    assign cout = cout_temp[99];

endmodule