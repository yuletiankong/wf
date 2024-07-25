#include "bubbleSort.h"
#include <gtest/gtest.h>
#include <cstdlib>
#include <ctime>

// Helper function to check if an array is sorted
bool isSorted(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            return false;
        }
    }
    return true;
}

// Test fixture for BubbleSort
class BubbleSortTest : public ::testing::Test {
protected:
    static void SetUpTestSuite() {
        // Initialize random seed
        std::srand(std::time(nullptr));
    }

    void generateRandomArray(int*& arr, int& n) {
        // Generate a random size for the array (between 100 and 1000)
        n = 100 + std::rand() % 901;
        arr = new int[n];
        // Fill the array with random numbers
        for (int i = 0; i < n; i++) {
            arr[i] = std::rand();
        }
    }
};

// Generate and test 10000 random arrays
TEST_F(BubbleSortTest, RandomArrays) {
    for (int i = 0; i < 10000; i++) {
        int* arr;
        int n;
        generateRandomArray(arr, n);
        bubbleSort(arr, n);
        ASSERT_TRUE(isSorted(arr, n));
        delete[] arr;
        printf("Test %d passed\n", i);
    }
}