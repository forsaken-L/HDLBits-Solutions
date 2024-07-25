module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err
);
    parameter NONE = 0, ONE = 1, TWO = 2, THREE = 3, FOUR = 4, FIVE = 5, 
              SIX = 6, ERROR = 7, DISCARD = 8, FLAG = 9;

    reg [3:0] state, next_state;

    always @( * ) begin
        case (state)
            NONE   : next_state = in? ONE: NONE;
            ONE    : next_state = in? TWO: NONE;
            TWO    : next_state = in? THREE: NONE;
            THREE  : next_state = in? FOUR: NONE;
            FOUR   : next_state = in? FIVE: NONE;
            FIVE   : next_state = in? SIX: DISCARD;
            SIX    : next_state = in? ERROR: FLAG;
            ERROR  : next_state = in? ERROR: NONE;
            DISCARD: next_state = in? ONE: NONE;
            FLAG   : next_state = in? ONE: NONE;  
        endcase
    end
    
    always @(posedge clk ) begin
        if (reset) begin
            state<= NONE;
        end else begin
            state<= next_state;
        end
    end

    assign disc = (state==DISCARD);
    assign flag = (state==FLAG);
    assign err = (state==ERROR);
endmodule
