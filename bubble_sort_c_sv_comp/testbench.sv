module testbench;
    reg [31:0] data_in [0:99];
    wire [31:0] data_out [0:99];
    integer i;
    integer file;

    bubble_sort uut (
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        file = $fopen("test_vectors.txt", "r");
        for (i = 0; i < 100; i = i + 1) begin
            $fscanf(file, "%d\n", data_in[i]);
        end
        $fclose(file);

        #10; // 等待排序完成

        file = $fopen("verilog_sorted_vectors.txt", "w");
        for (i = 0; i < 100; i = i + 1) begin
            $fwrite(file, "%d\n", data_out[i]);
        end
        $fclose(file);

        $finish;
    end
endmodule