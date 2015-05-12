/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 32
#------------------------------------------------------------------------------
# We shall say that an n-digit number is pandigital if it makes use of all the 
# digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 
# through 5 pandigital.
# 
# The product 7254 is unusual, as the identity, 39  186 = 7254, containing 
# multiplicand, multiplier, and product is 1 through 9 pandigital.
# 
# Find the sum of all products whose multiplicand/multiplier/product identity
# can be written as a 1 through 9 pandigital.
#
# HINT: Some products can be obtained in more than one way so be sure to only 
# include it once in your sum.
#------------------------------------------------------------------------------
# SOLUTION: 45228
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
#include <cmath>
using namespace std;

bool hasPandigitalFactors(int);
bool isPandigital(string, int, int);
int toInt(char);

int main(){
    int sum = 0;
    for(int i = 1000; i < 10000; i++)
        if(hasPandigitalFactors(i)) sum += i;
    cout << sum << endl;
    return 0;
}

bool hasPandigitalFactors(int n){
    for(int i = 1; i <= sqrt(n); i++){
        if(n % i == 0){
            int j = n / i;
            stringstream s;
            s << i << j << n;
            if(isPandigital(s.str(), 1, 9)) return true;
        }
    }
    return false;
}

bool isPandigital(string s, int lo, int hi){
    if (s.length() != 1+hi-lo) return false;

    int check[s.length()];
    for (int i = 0; i <= s.length(); i++)
        check[i] = 0;

    for (int i = 0; i < s.length(); i++)
        if (++check[toInt(s[i])] == 2) return false;

    for (int i = lo; i <= hi; i++)
        if (check[i] == 0) return false;

    return true;
}

int toInt(char c){
    return c - '0';
}
