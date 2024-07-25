module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z 
); 
    parameter s0 = 0, //idle
              s1 = 1, //1
              s2 = 2; //10
    reg [2:0] state, next_state;

    always @( * ) begin
        case (state)
            s0: next_state = x? s1: s0;
            s1: next_state = x? s1: s2;
            s2: next_state = x? s1: s0;
        endcase
    end
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state<= s0;
        end else begin
            state<= next_state;
        end
    end

    assign z = (state==s2) && x; 
endmodule
