/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 30
#------------------------------------------------------------------------------
# Surprisingly there are only three numbers that can be written as the sum of 
# fourth powers of their digits:
# 
# 1634 = 14 + 64 + 34 + 44
# 8208 = 84 + 24 + 04 + 84
# 9474 = 94 + 44 + 74 + 44
# As 1 = 14 is not a sum it is not included.
#
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
# 
# Find the sum of all the numbers that can be written as the sum of fifth 
# powers of their digits.
#------------------------------------------------------------------------------
# SOLUTION: 443839
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
#include <sstream>
using namespace std;

string toString(int);
int toInt(char);

int main(){
    int total = 0;
    for (int i = 2; i > 0; i++){
        string s = toString(i);
        int sum = 0;
        for (int j = 0; j < s.length(); j++){
            sum += pow(toInt(s[j]), 5);
        }
        if(sum == i) {
            cout << sum << endl;
            total += sum;
        }
    }
    cout << total;
    return 0;
}

string toString(int n){
    stringstream s;
    s << n;
    return s.str();
}

int toInt(char c){
    return c - '0';
}
