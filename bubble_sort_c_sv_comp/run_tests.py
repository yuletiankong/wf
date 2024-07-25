import subprocess

def run_c_program():
	# 编译C程序
	subprocess.run(["gcc", "bubble_sort.c", "-o", "bubble_sort"], check=True)
	# 运行编译后的C程序
	subprocess.run(["bubble_sort"], check=True)

def run_verilog_simulation():
	# 编译Verilog代码
	subprocess.run(["vlog", "bubble_sort.sv", "testbench.sv"], check=True)
	# 运行Verilog仿真
	subprocess.run(["vsim", "-c", "-do", "run -all; quit", "testbench"], check=True)

def compare_results():
	with open("sorted_vectors.txt", "r") as c_file, open("verilog_sorted_vectors.txt", "r") as v_file:
		c_sorted = [line.strip() for line in c_file.readlines()]
		print(c_sorted)
		v_sorted = [line.strip() for line in v_file.readlines()]
		print(v_sorted)

	if c_sorted == v_sorted:
		print("Test passed: C and Verilog outputs match.")
	else:
		print("Test failed: C and Verilog outputs do not match.")

if __name__ == "__main__":
	run_c_program()
	run_verilog_simulation()
	compare_results()