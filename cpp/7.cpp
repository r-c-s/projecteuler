/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 2
#------------------------------------------------------------------------------
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
# that the 6th prime is 13.
#
# What is the 10 001st prime number?
#------------------------------------------------------------------------------
# SOLUTION: 104743
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

bool isPrime(int);

int main(){
    int numberOfPrimes = 1;
    int prime = 0;
    for (int i = 3; numberOfPrimes < 10001; i += 2){
        if (isPrime(i)){
            prime = i;
            numberOfPrimes++;
        }
    }
    cout << numberOfPrimes << endl;
    cout << prime << endl;
}

bool isPrime(int i){
    for (int j = 3; j < i; j+=2){
        if (i % j == 0){
            return false;
        }
    }
    return true;
}
