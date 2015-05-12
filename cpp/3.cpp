/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 3
#------------------------------------------------------------------------------
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#------------------------------------------------------------------------------
# SOLUTION: 6857
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

bool isPrime(int);

int main(){
    unsigned long long num = 600851475143;
    int limit = sqrt(num);
	cout << limit << endl;
    int largest;
    for(int i = 1; i <= limit; i+=2){
        if (num % i == 0)
            if(isPrime(i)) largest = i;
    }
    cout << "The largest prime factor of " << num;
    cout << " is " << largest << endl;
    return 0;
}

bool isPrime(int n){
    if (n < 2) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;
    for (int j = 3; j < sqrt(n); j+=2)
        if (n % j == 0) return false;
    return true;
}
