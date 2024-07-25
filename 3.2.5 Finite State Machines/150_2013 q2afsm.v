module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A = 0, B = 1, C = 2, D = 3;
    reg [2:0] state, next_state;

    always @( * ) begin
        case (state)
            A: if (r[1]) begin
                next_state = B;
            end else if (~r[1]&&r[2]) begin
                next_state = C;
            end else if (~r[1]&&~r[2]&&r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
            B: if (r[1]) begin
                next_state = B;
            end else begin
                next_state = A;
            end 
            C: if (r[2]) begin
                next_state = C;
            end else begin
                next_state = A;
            end
            D: if (r[3]) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        endcase
    end

    always @(posedge clk ) begin
        if (~resetn) begin
            state<= A;
        end else begin
            state<= next_state;
        end
    end

    assign g[1] = (state==B);
    assign g[2] = (state==C);
    assign g[3] = (state==D);
endmodule
