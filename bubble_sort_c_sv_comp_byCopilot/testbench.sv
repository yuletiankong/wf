`include "test_params.svh"
module testbench;
    reg clk;
    reg rst;
    reg start;
    reg [31:0] data_in [0:`NUM_TESTS_DEEP-1];
    wire [31:0] data_out [0:`NUM_TESTS_DEEP-1];
    integer file, i, k;
    reg done;

    // 实例化被测试模块
    bubble_sort uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .data_out(data_out),
        .done(done)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 初始化和测试向量
    initial begin
        $display("Simulation started...");
        rst = 1;
        start = 0;
        #10;
        rst = 0;
        $display("Reset deasserted at time %t", $time);

        for (k = 0; k < `NUM_TESTS; k = k + 1) begin
            string filename;
            filename = $sformatf({`INPUT_DIR,"/",`INPUT_DIR,"_%0d.txt"}, k);
            file = $fopen(filename, "r");
            if (file == 0) begin
                $display("Failed to open file %s.", filename);
                $finish;
            end

            for (i = 0; i < `NUM_TESTS_DEEP; i = i + 1) begin
                if ($fscanf(file, "%d\n", data_in[i]) != 1) begin
                    $display("Failed to read data at index %d from file %s", i, filename);
                    $finish;
                end
            end
            $fclose(file);

            #10;
            start = 1; // 设置启动信号
            $display("Start signal asserted at time %t", $time);
            #10;
            start = 0; // 清除启动信号
            $display("Start signal deasserted at time %t", $time);

            // 等待 done 信号
            $display("Wait Done signal deasserted at time %t", $time);
            @(posedge done) begin
                // 将结果写入文件
                filename = $sformatf({`OUTPUT_DIR,"/verilog_sorted_vectors_%0d.txt"}, k);
                file = $fopen(filename, "w");
                if (file == 0) begin
                    $display("Failed to open output file %s.", filename);
                    $finish;
                end
                for (i = 0; i < `NUM_TESTS_DEEP; i = i + 1) begin
                    $fwrite(file, "%d\n", data_out[i]);
                end
                $fclose(file);
                $display("Results written to %s at time %t", filename, $time);
            end
            #10;
        end

        $finish;
    end

    // 监视 done 信号
    always @(posedge clk) begin
        if (done) begin
            // 处理完成信号
            //$display("data_in[0] == %d",uut.data_in[0]);
            //$display("data_out[0] == %d",uut.data_out[0]);
        end
    end

endmodule