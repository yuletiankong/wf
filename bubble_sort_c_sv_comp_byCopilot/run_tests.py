import os
import shutil
import subprocess
# generate_params.py

NUM_TESTS = 300
NUM_TESTS_DEEP = 200
INPUT_DIR = "input_vectors"
OUTPUT_DIR = "output"
SORTED_DIR = "sorted_vectors"

def clean_directories():
    directories = [INPUT_DIR, OUTPUT_DIR, SORTED_DIR]
    for directory in directories:
        if os.path.exists(directory):
            shutil.rmtree(directory)
        os.makedirs(directory)

def generate_sv_header():
    with open("test_params.svh", "w") as f:
        f.write(f"`ifndef TEST_PARAMS_SVH\n")
        f.write(f"`define TEST_PARAMS_SVH\n\n")
        f.write(f"`define NUM_TESTS {NUM_TESTS}\n")
        f.write(f"`define NUM_TESTS_DEEP {NUM_TESTS_DEEP}\n")
        f.write(f"`define INPUT_DIR \"{INPUT_DIR}\"\n")
        f.write(f"`define OUTPUT_DIR \"{OUTPUT_DIR}\"\n")
        f.write(f"`define SORTED_DIR \"{SORTED_DIR}\"\n\n")
        f.write(f"`endif // TEST_PARAMS_SVH\n")

def generate_c_header():
    with open("test_params.h", "w") as f:
        f.write(f"#ifndef TEST_PARAMS_H\n")
        f.write(f"#define TEST_PARAMS_H\n\n")
        f.write(f"#define NUM_TESTS {NUM_TESTS}\n")
        f.write(f"#define NUM_TESTS_DEEP {NUM_TESTS_DEEP}\n")
        f.write(f"#define INPUT_DIR \"{INPUT_DIR}\"\n")
        f.write(f"#define OUTPUT_DIR \"{OUTPUT_DIR}\"\n")
        f.write(f"#define SORTED_DIR \"{SORTED_DIR}\"\n\n")
        f.write(f"#endif // TEST_PARAMS_H\n")

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
	for i in range(NUM_TESTS):
		c_file_path = f"{SORTED_DIR}/{SORTED_DIR}_{i}.txt"
		v_file_path = f"{OUTPUT_DIR}/verilog_sorted_vectors_{i}.txt"
        
		with open(c_file_path, "r") as c_file, open(v_file_path, "r") as v_file:
			c_sorted = [line.strip() for line in c_file.readlines()]
			v_sorted = [line.strip() for line in v_file.readlines()]
		
		if c_sorted == v_sorted:
			print(f"Test {i} passed: C and Verilog outputs match.")
		else:
			print(f"Test {i} failed: C and Verilog outputs do not match.")

if __name__ == "__main__":
	clean_directories()
	generate_sv_header()
	generate_c_header()
	run_c_program()
	run_verilog_simulation()
	compare_results()