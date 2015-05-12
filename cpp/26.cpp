/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 26
#------------------------------------------------------------------------------
# A unit fraction contains 1 in the numerator. The decimal representation of
# the unit fractions with denominators 2 to 10 are given:
#
# 1/2	= 	0.5
# 1/3	= 	0.(3)
# 1/4	= 	0.25
# 1/5	= 	0.2
# 1/6	= 	0.1(6)
# 1/7	= 	0.(142857)
# 1/8	= 	0.125
# 1/9	= 	0.(1)
# 1/10	= 	0.1
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
# seen that 1/7 has a 6-digit recurring cycle.
# 
# Find the value of d  1000 for which 1/d contains the longest recurring cycle
# in its decimal fraction part.
#------------------------------------------------------------------------------
# SOLUTION: 983
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

bool isPrime(int);

int main(){
    int count;
    int num;
    int max = 0;
    int n;
    for (int i = 999; i > 0; i-=2){
        int count = 0;
        if (isPrime(i)){
            n = 1;
            do{
                n = (n * 10) % i;
                if (n) count++;
            }while(n > 1);
            if (count > max){
                max = count;
                num = i;
            }
        }
    }
    cout << "Cycle length: " << max << endl;
    cout << "For value: " << num << endl;
}

bool isPrime(int k){
    if (k < 0) k *= -1;
    if (k == 2) return true;
    if (k % 2 == 0) return false;
    for (int i = 3; i <= sqrt(k); i+=2){
        if (k % i == 0) return false;
    }
    return true;
}
