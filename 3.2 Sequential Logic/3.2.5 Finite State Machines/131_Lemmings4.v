module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging 
);
    parameter LEFT = 0, RIGHT = 1, FALL_L = 2, FALL_R = 3, DIG_L = 4, DIG_R = 5, SPLAT = 6;
    reg [2:0] state, next_state;
    reg [99:0] count;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state<= LEFT;
        end else if (state==FALL_L || state==FALL_R) begin
            state<= next_state;
            count<= count+1;
        end else begin
            state<= next_state;
            count<= 0;
        end
    end

    always @( * ) begin
        case (state)
            LEFT:begin
                if (!ground) begin
                    next_state = FALL_L;
                end else if (dig)begin
                    next_state = DIG_L;
                end else begin
                    next_state = bump_left? RIGHT: LEFT;
                end
            end 

            RIGHT: begin
                if (!ground) begin
                    next_state = FALL_R;
                end else if (dig) begin
                    next_state = DIG_R;
                end else begin
                    next_state = bump_right? LEFT: RIGHT;
                end
            end

            FALL_L: begin
                if (ground) begin
                    if (count > 19) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = LEFT;
                    end
                end else begin
                    next_state = FALL_L;
                end
            end

            FALL_R: begin
                if (ground) begin
                    if (count > 19) begin
                        next_state = SPLAT;
                    end else begin
                        next_state = RIGHT;
                    end
                end else begin
                    next_state = FALL_R;
                end
            end

            DIG_L: next_state = ground? DIG_L: FALL_L;
            DIG_R: next_state = ground? DIG_R: FALL_R;
            SPLAT: next_state = SPLAT;

        endcase
    end

    assign walk_left = (state==LEFT);
    assign walk_right = (state==RIGHT);
    assign digging = (state==DIG_L)||(state==DIG_R);
    assign aaah = (state==FALL_L)||(state==FALL_R);




endmodule
