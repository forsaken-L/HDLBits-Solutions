module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);
    parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4;
    reg [2:0] state, next_state;

    always @( * ) begin
        case (state)
            s0: next_state = reset? s0: s1;
            s1: next_state = reset? s0: s2;
            s2: next_state = reset? s0: s3;
            s3: next_state = reset? s0: s4;
            s4: next_state = s4;
        endcase
    end

    always @(posedge clk ) begin
        if (reset) begin
            state<= s0;
        end else begin
            state<= next_state;
        end
    end
    
    assign shift_ena = !(state==s4);
endmodule
