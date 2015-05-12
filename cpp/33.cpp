/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 33
#------------------------------------------------------------------------------
#The fraction 49/98 is a curious fraction, as an inexperienced mathematician
# in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which
# is correct, is obtained by cancelling the 9s.
#
# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
#
# There are exactly four non-trivial examples of this type of fraction, less
# than one in value, and containing two digits in the numerator and denominator.
#
#If the product of these four fractions is given in its lowest common terms,
# find the value of the denominator.
#------------------------------------------------------------------------------
# SOLUTION: 100
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
#include <cmath>
using namespace std;

bool is(int, int);
string simplify(int, int);

int main(){
    int n = 1;
    int d = 1;
    for(int i = 10; i <= 99; i++){
        for(int j = i+1; j <= 99; j++){
            if(is(i, j)){
                cout << i << "/" << j << endl;
                n*=i;
                d*=j;
            }
        }
    }
    cout << simplify(n, d) << endl;
    return 0;
}

bool is(int a, int b){
    if(a%10 != b/10) return false;
    return (double)(a/10) / (b%10) == (double)a / b;
}

string simplify(int n, int d){
    int min = n;
    if (d < n) min = d;
    for(int i = 2; i <= sqrt(min); i++){
        while(n % i == 0 && d % i == 0){
            n /= i;
            d /= i;
        }
    }
    stringstream s;
    s << n << "/" << d;
    return s.str();
}
