/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 27
#------------------------------------------------------------------------------
# Euler published the remarkable quadratic formula:
#
# n² + n + 41
#
# It turns out that the formula will produce 40 primes for the consecutive 
# values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 
# is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly 
# divisible by 41.
#
# Using computers, the incredible formula  n² - 79n + 1601 was discovered, 
# which produces 80 primes for the consecutive values n = 0 to 79. The
# product of the coefficients, -79 and 1601, is 126479.
#
# Considering quadratics of the form:
#
# n² + an + b, where |a| < 1000 and |b| < 1000
#
# where |n| is the modulus/absolute value of n
# e.g. |11| = 11 and |-4| = 4
#Find the product of the coefficients, a and b, for the quadratic expression 
# that produces the maximum number of primes for consecutive values of n,
# starting with n = 0.
#------------------------------------------------------------------------------
# SOLUTION: -59231
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

int quadratic(int, int, int);
bool isPrime(int);

int main(){
    int a = 0;
    int b = 0;
    int n = 0;
    int count = 0;
    int max = 0;
    for (int i = -999; i < 1000; i++){
        for (int j = -999; j < 1000; j++){
            count = 0;
            n = 0;
            while (isPrime(quadratic(n++, i, j))){
                count++;
            }
            if (count > max){
                max = count;
                a = i;
                b = j;
            }
        }
    }
    cout << max << endl;
    cout << a << " * " << b << " = " << a*b << endl;
    return 0;
}

int quadratic(int n, int a, int b){
    return n*n + n*a + b;
}

bool isPrime(int k){
    if (k < 0) k *= -1;
    if (k == 2) return false;
    if (k % 2 == 0) return false;
    for (int i = 3; i <= sqrt(k); i+=2){
        if (k % i == 0) return false;
    }
    return true;
}
