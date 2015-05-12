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

bool abundant(int);

const int L = 20161; //greatest number that CANNOT be expressed as the sum of two abundant numbers
const int N = 4994;  //amount of abundant numbers below L

int * a = new int[N]; //array of abundant numbers
int * b = new int[L+1]; //array of all numbers <= L

int main(){
    int index = 0;
    long unsigned s = 0;

    //computes abundant numbers
    for (int i = 0; i <= L; i++){
        if (abundant(i)) a[index++] = i;
    }

    //defines b[i] = i
    for (int i = 0; i <= L; i++){
        b[i] = i;
    }

    //b[sum of two abundant numbers] = 0
    for (int i = 0; i < N; i++){
        for (int j = 0; j < N; j++){
            int k = a[i] + a[j];
            if (k > L) break;
            b[k] = 0;
        }
    }

    //sums all elements in b
    for (int i = 0; i <= L; i++){
        s += b[i];
    }

    cout << s;
}

bool abundant(int n){
    int sum = 0;
    for (int i = 1; i <= n/2; i++){
        if (n % i == 0){
            sum += i;
            if (sum > n) return true;
        }
    }
    return false;
}
