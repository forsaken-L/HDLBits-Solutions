module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter  A = 0, f_high = 1, s0 = 2, s1 = 3, s2 = 4, s3 = 5,
               g_high = 6, g_high_temp = 7, g_low = 8;

    reg [3:0] state, next_state;

    always @( * ) begin
        case (state)
            A             : next_state = f_high;
            f_high        : next_state = s0;
            s0            : next_state = x? s1: s0;
            s1            : next_state = x? s1: s2;
            s2            : next_state = x? s3: s0;
            s3            : next_state = y? g_high: g_high_temp;
            g_high_temp   : next_state = y? g_high: g_low;
            g_high        : next_state = g_high;
            g_low         : next_state = g_low;
        endcase
    end

    always @(posedge clk ) begin
        if (~resetn) begin
            state<= A;
        end else begin
            state<= next_state;
        end
    end

    assign f = (state==f_high);
    assign g = (state==g_high || state==g_high_temp || state==s3);

endmodule
