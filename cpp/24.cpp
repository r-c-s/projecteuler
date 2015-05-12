/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 35
#------------------------------------------------------------------------------
# The number, 197, is called a circular prime because all rotations of the 
# digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
# 71, 73, 79, and 97.
#
# How many circular primes are there below one million?
#------------------------------------------------------------------------------
# SOLUTION: 55
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

void nextPermutation(int[], int);
void next(int[], int, int);
void prevPermutation(int[], int);
void prev(int[], int, int);

int nums[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

int main(){
    for (int j = 1; j < 1000000; j++)
        nextPermutation(nums, 10);

    for (int i = 0; i < 10; i++)
        cout << nums[i];

    return 0;
}

void nextPermutation(int a[], int i){
    int j = i--;
    next(a, --i, j);
}

void next(int a[], int i, int j){
    if(a[i] < a[i+1]){
        int save = j;
        while (a[i] > a[--j]);
        int temp = a[j];
        a[j] = a[i];
        a[i] = temp;
        j = --save;
        while(i+1 <= j){
            temp = a[i+1];
            a[1+i++] = a[j];
            a[j--] = temp;
        }
        return;
    }
    next(a, --i, j);
}

void prevPermutation(int a[], int i){
    int j = i--;
    prev(a, --i, j);
}

void prev(int a[], int i, int j){
    if(a[i] > a[i+1]){
        int save = j;
        while (a[i] < a[--j]);
        int temp = a[j];
        a[j] = a[i];
        a[i] = temp;
        j = --save;
        while(i+1 < j){
            temp = a[i+1];
            a[1+i] = a[j];
            a[j] = temp;
	    j--;i++;
        }
        return;
    }
    prev(a, --i, j);
}
