// bubble_sort_tb.v
module bubble_sort_tb;
    reg [31:0] in_data [0:9]; // 修改数组大小为10
    wire [31:0] out_data [0:9]; // 修改数组大小为10
    integer i;
    integer input_file;

    bubble_sort uut (
        .in_data(in_data),
        .out_data(out_data)
    );

    initial begin
        // 打开标准输入
        input_file = $fopen("input_data.txt", "r");

        // 从标准输入读取数组
        for (i = 0; i < 10; i = i + 1) begin
            $fscanf(input_file, "%d", in_data[i]);
        end

        #10;
        $finish;
    end

    initial begin
        $monitor("Time=%t, out_data=%d %d %d %d %d %d %d %d %d %d", $time, out_data[0], out_data[1], out_data[2], out_data[3], out_data[4], out_data[5], out_data[6], out_data[7], out_data[8], out_data[9]);
    end
endmodule