/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 10
#------------------------------------------------------------------------------
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.
#------------------------------------------------------------------------------
# SOLUTION: 142913828922
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

bool isPrime(int);

int main(){
    long long sum = 2LL;
    for (int i = 3; i <= 2000000; i+=2){
        if (isPrime(i)){
            sum += i;
        }
    }
    cout << sum << endl;
    return 0;
}

bool isPrime(int i){
    for (int j = 2; j <= sqrt(i); j++){
        if (i % j == 0){
            return false;
        }
    }
    return true;
}
