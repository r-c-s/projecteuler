/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 28
#------------------------------------------------------------------------------
# Starting with the number 1 and moving to the right in a clockwise direction 
# a 5 by 5 spiral is formed as follows:
# 
# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11
# 18  5  4  3 12
# 17 16 15 14 13
# 
# It can be verified that the sum of the numbers on the diagonals is 101.
# 
# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral 
# formed in the same way?
#------------------------------------------------------------------------------
# SOLUTION: 669171001
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

int main(){
    const int N = 1002001;
    int current = 1;
    int step = 2;
    int sum = 0;
    while(current < N){
        int i = 0;
        for (int k = current; i < 4; k+=step){
            sum += k;
            i++;
            current += step;
        }
        step += 2;
    }
    cout << sum+N << endl;
}
