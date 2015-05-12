/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 5
#------------------------------------------------------------------------------
# 2520 is the smallest number that can be divided by each of the numbers from 
# 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the 
# numbers from 1 to 20?
#------------------------------------------------------------------------------
# SOLUTION: 232792560
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

bool isDivisible(int, int);

int main(){
    for(int i = 20; true; i+=2){
        if(isDivisible(i, 20)){
            cout << i << endl;
            break;
        }
    }
    return 0;
}

bool isDivisible(int i, int d){
    for(int j = d; j > 1; j--){
        if(i % j != 0){
            return false;
        }
    }
    return true;
}
