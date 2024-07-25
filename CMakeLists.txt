cmake_minimum_required(VERSION 3.5.0)
project(test VERSION 0.1.0 LANGUAGES C CXX)
# add_executable(my_test main.cpp)

# Update the path to the correct location of the Google Test library
add_subdirectory(external/googletest)

enable_testing()
include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

# 添加你的测试可执行文件
add_executable(test_bubbleSort bubble_sort_c_test/test_bubbleSort.cpp)
# 链接 Google Test 到你的测试目标
target_link_libraries(test_bubbleSort gtest gtest_main)
add_test(NAME test_bubbleSort COMMAND test_bubbleSort)