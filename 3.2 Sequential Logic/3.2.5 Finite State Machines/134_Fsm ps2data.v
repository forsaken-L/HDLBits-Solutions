module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
); //
    // FSM from fsm_ps2
    parameter byte1 = 1, byte2 = 2, byte3 = 3,DONE = 4;
    reg [2:0] state, next_state;

    // State transition logic (combinational)
    always @( * ) begin
        case (state)
            byte1: next_state = (in[3])? byte2: byte1;
            byte2: next_state = byte3;
            byte3: next_state = DONE;
            DONE:  next_state = (in[3])? byte2: byte1;
        endcase
    end

    // State flip-flops (sequential)
    always @(posedge clk ) begin
        if (reset) begin
            state<= byte1;
        end else begin
            state<= next_state;
        end
    end

    assign done = (state==DONE);


    // New: Datapath to store incoming bytes.
    always @(posedge clk ) begin
        if (reset) begin
            out_bytes<= 24'b0;
        end else begin
            out_bytes<= {out_bytes[15:0], in[7:0]};
        end
    end

endmodule
