/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 4
#------------------------------------------------------------------------------
# A palindromic number reads the same both ways. 
# The largest palindrome made from the product of two 2-digit numbers is 
# 9009 = 91 * 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.
#------------------------------------------------------------------------------
# SOLUTION: 906609
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
using namespace std;

bool isPalindromic(int);

int main(){
    int largest = 0;
    int prod = 0;
    for (int i = 999; i >= 100; i--){
        for (int j = i; j >= 100; j--){
            prod = i*j;
            if(prod > largest && isPalindromic(prod)){
                largest = prod;
            }
        }
    }
    cout << largest << endl;
    return 0;
}

bool isPalindromic(int n){
    stringstream s;
    s << n;
    string num = s.str();
    int length = num.length();
    for (int i = 0; i < length/2; i++){
        if (num[i] != num[length-i-1]) return false;
    }
    return true;
}
