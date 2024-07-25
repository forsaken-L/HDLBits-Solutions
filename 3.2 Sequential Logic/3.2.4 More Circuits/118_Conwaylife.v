module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q 
);
    reg  [3:0] sum;
    integer i, j;
    always @(posedge clk ) begin
        if (load) begin
            q <= data;
        end else begin
            for (i = 0;i<256 ;i++ ) begin
                if (i==0) begin
                    sum = q[1] + q[15] + q[16] + q[17] + q[31] + q[240] + q[241] + q[255];
                end
                else if (i==15) begin
                    sum = q[0] + q[14] + q[16] + q[30] + q[31] + q[240] + q[254] + q[255];
                end
                else if (i==240) begin
                    sum = q[0] + q[1] + q[15] + q[224] + q[225] + q[239] + q[241] + q[255];
                end
                else if (i==255) begin
                    sum = q[0] + q[14] + q[15] + q[224] + q[238] + q[239] + q[240] + q[254];
                end
                else if (i%16==0) begin
                    sum = q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i+17] + q[i-16] + q[i-15] + q[i+31];
                end
                else if (i%16==15) begin
                    sum = q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i-17] + q[i-16] + q[i-15] + q[i-31];
                end
                else if (i>0 && i<15) begin
                    sum = q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i+17] + q[i+239] + q[i+240] + q[i+241];
                end
                else if (i>240 && i<255) begin
                    sum = q[i-1] + q[i+1] + q[i-17] + q[i-16] + q[i-15] + q[i-239] + q[i-240] + q[i-241];
                end
                else begin
                    sum = q[i-1] + q[i+1] + q[i-17] + q[i-16] + q[i-15] + q[i+15] + q[i+16] + q[i+17];
                end
                case (sum)
                    4'b0010: q[i] <= q[i]; 
                    4'b0011: q[i] <= 1;
                    default: q[i] <= 0;
                endcase
            end

        end
    end 

endmodule
