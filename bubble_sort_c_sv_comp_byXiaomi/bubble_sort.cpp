#include <stdio.h>
#include <stdlib.h>

int main() {
    int *arr = NULL;
    int num;
    int count = 0;
    int capacity = 10;

    // 动态分配初始内存
    arr = (int *)malloc(capacity * sizeof(int));
    if (arr == NULL) {
        fprintf(stderr, "Memory allocation failed\n");
        return 1;
    }

    // 从标准输入读取数组
    while (scanf("%d", &num) == 1) {
        if (count >= capacity) {
            capacity *= 2;
            arr = (int *)realloc(arr, capacity * sizeof(int));
            if (arr == NULL) {
                fprintf(stderr, "Memory reallocation failed\n");
                return 1;
            }
        }
        arr[count++] = num;
    }

    // 执行冒泡排序
    for (int i = 0; i < count - 1; ++i) {
        for (int j = 0; j < count - i - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }

    // 输出排序后的数组
    printf("Sorted array:\n");
    for (int i = 0; i < count; ++i) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    // 释放内存
    free(arr);

    return 0;
}