import subprocess
import re
import random

def run_command(command, input_data=None):
    print(f"Running command: {command}")
    try:
        result = subprocess.run(command, shell=True, check=True, input=input_data, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        print(f"Command output: {result.stdout}")
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error occurred: {e.stderr}")
        return None

def extract_sorted_array(output):
    matches = re.findall(r"Sorted array:\s*\n((?:\d+\s*)+)", output)
    return [list(map(int, x.split())) for x in matches] if matches else []

def extract_verilog_output(output):
    matches = re.findall(r"Time=\s*\d+,\s*out_data=\s*((?:\d+\s*)+)", output)
    return [list(map(int, x.split())) for x in matches] if matches else []

def generate_random_array(size, lower_bound=0, upper_bound=100):
    return [random.randint(lower_bound, upper_bound) for _ in range(size)]

def array_to_string(array):
    return ' '.join(map(str, array))

# 生成随机数组
random_array = generate_random_array(10)
input_data = array_to_string(random_array)

# 将输入数据写入文件
with open("input_data.txt", "w") as f:
    f.write(input_data)

# 运行C程序并获取输出
c_output_str = run_command("gcc ./bubble_sort.cpp -o bubble_sort && bubble_sort", input_data)
c_output = extract_sorted_array(c_output_str) if c_output_str else []

# 运行Verilog仿真
verilog_output_str = run_command("iverilog -o bubble_sort_sim -g2012 bubble_sort.sv bubble_sort_tb.sv && vvp bubble_sort_sim")
verilog_output = extract_verilog_output(verilog_output_str) if verilog_output_str else []

# 调试信息
print("Random input array:")
print(random_array)
print("C program output:")
print(c_output)
print("Verilog simulation output:")
print(verilog_output)

# 比对结果
if c_output and verilog_output:
    if c_output == verilog_output:
        print("The outputs match.")
    else:
        print("The outputs do not match.")
else:
    print("One or both programs failed to run correctly.")