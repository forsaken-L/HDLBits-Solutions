module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state<= 2'b01;
        end else begin
            if (train_valid) begin
                if (train_taken==1 && state<3) begin
                    state<= state+1;
                end else if (train_taken==0 && state>0) begin
                    state<= state-1;
                end else begin
                    state<= state;
                end
            end else begin
                state<= state;
            end
        end
    end


endmodule
