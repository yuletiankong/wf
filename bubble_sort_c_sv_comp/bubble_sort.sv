module bubble_sort(
    input [31:0] data_in [0:99],
    output reg [31:0] data_out [0:99]
);
    integer i, j;
    reg [31:0] temp;
    always @(*) begin
        data_out = data_in;
        for (i = 0; i < 100-1; i = i + 1) begin
            for (j = 0; j < 100-i-1; j = j + 1) begin
                if (data_out[j] > data_out[j+1]) begin
                    temp = data_out[j];
                    data_out[j] = data_out[j+1];
                    data_out[j+1] = temp;
                end
            end
        end
    end
endmodule