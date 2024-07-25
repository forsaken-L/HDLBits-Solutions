module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter IDLE = 0, START = 1, WAIT = 2, STOP = 3;
    reg [2:0] state, next_state;
    integer   count;

    always @( * ) begin
        case (state)
            IDLE: next_state = in? IDLE: START;
            START: begin
                if (count==8) begin
                    next_state = in? STOP: WAIT;
                end else begin
                    next_state = state;
                end
            end
            WAIT: next_state = in? IDLE: WAIT;
            STOP: next_state = in? IDLE: START;
        endcase
    end

    always @(posedge clk ) begin
        if (reset) begin
            state<= IDLE;
        end else begin
            state<= next_state;
        end
    end
    
    always @(posedge clk ) begin
        if (reset) begin
            count<= 0;
        end else begin
            if (state==START) begin
                count<= count + 1;
            end else if (state==START) begin
                count<= count;
            end else begin
                count<= 0;
            end
        end
        
    end

    assign done = (state == STOP);


endmodule
