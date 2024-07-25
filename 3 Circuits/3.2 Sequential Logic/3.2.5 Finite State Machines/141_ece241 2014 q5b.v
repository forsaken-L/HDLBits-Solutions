module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter A = 0, B = 1;
    reg [2:0] state, next_state;

    always @( * ) begin
        case (state)
            A : next_state = x? B: A;
            B : next_state = B;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state<= A;
        end else begin
            state<= next_state;
        end
    end

    always @( * ) begin
        case (state)
            A: z = x;
            B: z = ~x;  
        endcase
    end

endmodule
