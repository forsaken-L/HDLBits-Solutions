module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);
    wire [4:1] enable;
    assign enable[1] = ena && ss[3:0]==4'h9;
    assign enable[2] = enable[1] && ss[7:0]==8'h59;
    assign enable[3] = enable[2] && mm[3:0]==4'h9;
    assign enable[4] = enable[3] && mm[7:0]==8'h59;

    count #(.start_time(0), .end_time(4'h9)) ss_l (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .q(ss[3:0])
    );

    count #(.start_time(0), .end_time(4'h5)) ss_h (
        .clk(clk),
        .reset(reset),
        .ena(enable[1]),
        .q(ss[7:4])
    );

    count #(.start_time(0), .end_time(4'h9)) mm_l (
        .clk(clk),
        .reset(reset),
        .ena(enable[2]),
        .q(mm[3:0])
    );

    count #(.start_time(0), .end_time(4'h5)) mm_h (
        .clk(clk),
        .reset(reset),
        .ena(enable[3]),
        .q(mm[7:4])
    );

    count_hour count_hh(
        .clk(clk),
        .reset(reset),
        .ena(enable[4]),
        .pm(pm),
        .q(hh[7:0])
    );


endmodule

module count(
    input clk,
    input reset,
    input ena,
    output [3:0]q
);
    parameter  start_time= 0, end_time = 4'h9; 
    always @(posedge clk ) begin
        if (reset || (ena && q==end_time)) begin
            q <= start_time;
        end else begin
            q <= (ena)? q+1 : q;
        end
    end

endmodule

module count_hour (
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0]q
);
    always @(posedge clk ) begin
        if (reset) begin
            pm <= 0;
        end else begin
            pm <= (ena && q[7:0]==8'h11)? ~pm: pm;
        end
    end

    always @(posedge clk ) begin
        if (reset) begin
            q <= 8'h12; 
        end else if (~ena) begin
            q <= q;
        end else begin
            if (q[7:4] == 0 && q[3:0]<4'h9) begin
                q[7:4] <= 4'h0;
                q[3:0] <= q[3:0] + 1;
            end
            if (q[7:4] == 0 && q[3:0]==4'h9) begin
                q[7:4] <= 4'h1;
                q[3:0] <= 0;
            end
            if (q[7:4] == 1 && q[3:0]<4'h2) begin
                q[7:4] <= 4'h1;
                q[3:0] <= q[3:0] + 1;
            end
            if (q[7:4] == 1 && q[3:0]==4'h2) begin
                q[7:4] <= 4'h0;
                q[3:0] <= 4'h1;
            end
        end
    end

endmodule

// another way to count hour

/*   always @(posedge clk ) begin
        if (reset) begin
            q <= 8'h12; 
        end else if (~ena) begin
            q <= q;
        end else begin
            case (q)
                8'h09: q <= 8'h10;
                8'h12: q <= 8'h01; 
                default: q[3:0] <= q[3:0] + 1;
            endcase
        end
    end
*/