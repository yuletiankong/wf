#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void bubbleSort(int* arr, int n) {
    for (int i = 0; i < n-1; i++) {
        for (int j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

void generateRandomArray(int* arr, int n) {
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 1000;
    }
}

int main() {
    srand(time(NULL));
    int n = 100;
    int arr[n];
    generateRandomArray(arr, n);

    FILE* file = fopen("test_vectors.txt", "w");
    for (int i = 0; i < n; i++) {
        fprintf(file, "%d\n", arr[i]);
    }
    fclose(file);

    bubbleSort(arr, n);

    file = fopen("sorted_vectors.txt", "w");
    for (int i = 0; i < n; i++) {
        fprintf(file, "%d\n", arr[i]);
    }
    fclose(file);

    return 0;
}