/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 14
#------------------------------------------------------------------------------
# The following iterative sequence is defined for the set of positive integers:
#
# n  n/2 (n is even)
# n  3n + 1 (n is odd)
#
# Using the rule above and starting with 13, we generate the following sequence:
#
# 13  40  20  10  5  16  8  4  2  1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains
# 10 terms. Although it has not been proved yet (Collatz Problem), it is thought 
# that all starting numbers finish at 1.
#
# Which starting number, under one million, produces the longest chain?
#
# NOTE: Once the chain starts the terms are allowed to go above one million.
#------------------------------------------------------------------------------
# SOLUTION: 837799
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

int sequence(unsigned int);

int main(){
    int greatest = 0;
    int index = 0;
    for (unsigned int i = 0; i < 1000000; i++){
        int num = sequence(i);
        if (num > greatest){
            greatest = num;
            index = i;
        }
    }
    cout << index << "   " << greatest;
    return 0;
}

int sequence(unsigned int n){
    int numberOfTerms = 1;
    while (n > 1){
        numberOfTerms++;
        if (n % 2 == 0){
            n = n/2;
            continue;
        }
        n = 3*n + 1;
    }
    return numberOfTerms;
}
