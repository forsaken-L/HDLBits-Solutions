module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 0, B = 1;
    reg [2:0] state, next_state;
    reg [2:0] w_temp;
    reg [2:0] count;

    always @( * ) begin
        case (state)
            A: next_state = s? B: A;
            B: next_state = B;  
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
            w_temp<= 3'b0;
        end else begin
            if (state==B) begin
                w_temp<= {w_temp[1:0], w};    
            end
        end
    end

    always @(posedge clk ) begin
        if (reset) begin
            count<= 0;
        end else if (state==B)begin
            if (count==3'd2) begin
                count<= 3'd0;
            end else begin
                count<= count+1;
            end
        end
    end
    
    assign z = (state==B && count==3'd0 && (w_temp==3'b011 || w_temp==3'b101 || w_temp==3'b110));
endmodule
