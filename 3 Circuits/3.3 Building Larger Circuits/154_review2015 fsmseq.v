module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting
); 
    parameter idle = 0, s1 = 1, s11 = 2, s110 = 3, s1101 = 4;
    reg [2:0] state, next_state;

    always @( * ) begin
        case (state)
            idle: next_state = data? s1: idle;
            s1  : next_state = data? s11: idle;
            s11 : next_state = data? s11: s110;
            s110: next_state = data? s1101: idle; 
        endcase
    end

    always @(posedge clk ) begin
        if (reset) begin
            state<= idle;
        end else begin
            state<= next_state;
        end
    end

    assign start_shifting = (state==s1101);

endmodule
