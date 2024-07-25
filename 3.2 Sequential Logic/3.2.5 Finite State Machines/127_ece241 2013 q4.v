module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter A = 0, //below s1
              B = 1, //between s1 and s2
              C = 2, //between s2 and s3
              D = 3; //above s3
    reg [2:0] state, next_state, fr;
    assign {fr3, fr2, fr1} = fr;

    always @( * ) begin
        case (s)
            3'b000: next_state = A;
            3'b001: next_state = B;
            3'b011: next_state = C;
            3'b111: next_state = D; 
        endcase
    end
     
    always @(posedge clk ) begin
        if (reset) begin
            state<= A;
        end else begin
            state<= next_state;
        end
    end

    always @(posedge clk ) begin
        if (reset) begin
            fr <= 3'b111;
        end else begin
            case (next_state)
                A: fr<= 3'b111;
                B: fr<= 3'b011;
                C: fr<= 3'b001;
                D: fr<= 3'b000; 
            endcase
        end
    end

    always @(posedge clk ) begin
        if (reset) begin
            dfr<= 1'b1;
        end else begin
            if (next_state>state) begin
                dfr<= 1'b0;
            end else if (next_state<state) begin
                dfr<= 1'b1;
            end else begin
                dfr<= dfr;
            end
        end
    end

endmodule
