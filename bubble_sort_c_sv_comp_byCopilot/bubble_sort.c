#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "test_params.h"

void generateRandomArray(int* arr, int n) {
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 1000;
    }
}

void bubbleSort(int* arr, int n) {
    int i, j, temp;
    for (i = 0; i < n-1; i++) {
        for (j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

int main() {
    srand(time(NULL));
    //int n = 100;
    int arr[NUM_TESTS_DEEP];
    char filename[50];

    for (int k = 0; k < NUM_TESTS; k++) {
        generateRandomArray(arr, NUM_TESTS_DEEP);
        sprintf(filename, "%s/%s_%d.txt", INPUT_DIR, INPUT_DIR, k);
        FILE *file = fopen(filename, "w");
        if (file == NULL) {
            printf("Failed to open file %s\n", filename);
            return 1;
        }
        for (int i = 0; i < NUM_TESTS_DEEP; i++) {
            fprintf(file, "%d\n", arr[i]);
        }
        fclose(file);

        bubbleSort(arr, NUM_TESTS_DEEP);

        sprintf(filename, "%s/%s_%d.txt", SORTED_DIR, SORTED_DIR, k);
        file = fopen(filename, "w");
        if (file == NULL) {
            printf("Failed to open file %s\n", filename);
            return 1;
        }
        for (int i = 0; i < NUM_TESTS_DEEP; i++) {
            fprintf(file, "%d\n", arr[i]);
        }
        fclose(file);
    }

    printf("100 test vectors generated and written to test_vectors directory.\n");
    printf("100 sorted vectors generated and written to sorted_vectors directory.\n");
    return 0;
}