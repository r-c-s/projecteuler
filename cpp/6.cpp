/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 6
#------------------------------------------------------------------------------
# The sum of the squares of the first ten natural numbers is,
#
# 1^2 + 2^2 + ... + 10^2 = 385
# The square of the sum of the first ten natural numbers is,
#
# (1 + 2 + ... + 10)2 = 55^2 = 3025
# Hence the difference between the sum of the squares of the first ten natural 
# numbers and the square of the sum is 3025  385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred 
# natural numbers and the square of the sum.
#------------------------------------------------------------------------------
# SOLUTION: 25164150
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

int main(){
    int sumOfSquares = 0;
    int sum = 0;
    int squareOfSums = 0;
    int difference;
    for (int i = 0; i <= 100; i++){
        sumOfSquares += i * i;
        sum += i;
    }
    squareOfSums = sum * sum;
    difference = abs((float)sumOfSquares - squareOfSums);
    cout << difference << endl;
}
