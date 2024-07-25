module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack 
);
    parameter idle = 0, s1 = 1, s11 = 2, s110 = 3,  B0 = 4, B1 = 5, B2 = 6, B3 = 7,
              COUNT = 8, Wait = 9;
    reg [3:0] state, next_state;

    always @( * ) begin
        case (state)
            idle : next_state = data? s1: idle; 
            s1   : next_state = data? s11: idle;
            s11  : next_state = data? s11: s110;
            s110 : next_state = data? B0: idle;
            B0   : next_state = B1;
            B1   : next_state = B2;
            B2   : next_state = B3;
            B3   : next_state = COUNT;
            COUNT: next_state = done_counting? Wait: COUNT;
            Wait : next_state = ack? idle: Wait;
        endcase
    end

    always @(posedge clk ) begin
        if (reset) begin
            state<= idle;
        end else begin
            state<= next_state;
        end
    end

    assign shift_ena = (state==B0)||(state==B1)||(state==B2)||(state==B3);
    assign counting = (state == COUNT);
    assign done = (state==Wait);

endmodule
