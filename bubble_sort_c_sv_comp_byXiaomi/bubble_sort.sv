// bubble_sort.v
module bubble_sort (
    input [31:0] in_data [0:9], // 修改数组大小为10
    output reg [31:0] out_data [0:9] // 修改数组大小为10
);
    reg [31:0] data [0:9]; // 修改数组大小为10
    integer i, j;
    reg [31:0] temp;

    // 复制输入数据到内部寄存器
    always @(*) begin
        for (i = 0; i < 10; i = i + 1) begin
            data[i] = in_data[i];
        end

        // 冒泡排序
        for (i = 0; i < 9; i = i + 1) begin
            for (j = 0; j < 9 - i; j = j + 1) begin
                if (data[j] > data[j + 1]) begin
                    temp = data[j];
                    data[j] = data[j + 1];
                    data[j + 1] = temp;
                end
            end
        end

        // 复制排序后的数据到输出
        for (i = 0; i < 10; i = i + 1) begin
            out_data[i] = data[i];
        end
    end
endmodule