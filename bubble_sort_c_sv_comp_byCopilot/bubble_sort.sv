`include "test_params.svh"
module bubble_sort(
	input clk,
	input rst,
	input start,
	input [31:0] data_in [0:`NUM_TESTS_DEEP-1],
	output reg [31:0] data_out [0:`NUM_TESTS_DEEP-1],
	output reg done
);
	integer i, j;
	reg [31:0] temp;
	reg [6:0] state; // 用于状态机的状态变量

    reg start_locked;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            start_locked <= 0;
        end else begin
            if (start && !start_locked) begin
                start_locked <= 1;
            end else if (done) begin
                start_locked <= 0;
            end
        end
    end

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= 0;
			done <= 0;
			//data_out <= 0;
		end else if (start_locked) begin
			case (state)
				0: begin
					data_out <= data_in;
					i <= 0;
					j <= 0;
					done <= 0;
					state <= 1;
				end
				1: begin
					if (i < `NUM_TESTS_DEEP-1) begin
						if (j < `NUM_TESTS_DEEP-i-1) begin
							if (data_out[j] > data_out[j+1]) begin
								temp = data_out[j];
								data_out[j] = data_out[j+1];
								data_out[j+1] = temp;
							end
							j <= j + 1;
						end else begin
							j <= 0;
							i <= i + 1;
						end
						state <= 1; // 保持在状态1，等待下一个时钟周期
					end else begin
						done <= 0;
						state <= 2; // 进入完成状态
					end
				end
				2: begin
					done <= 1;
					state <= 0; // 进入完成状态// 完成状态，保持done信号为高
				end
			endcase
		end
	end
endmodule