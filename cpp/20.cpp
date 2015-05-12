/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 20
#------------------------------------------------------------------------------
# n! means n * (n * 1) * ... * 3 * 2 * 1
#
# For example, 10! = 10 * 9 * ... * 3 * 2 * 1 = 3628800,
# and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
#
# Find the sum of the digits in the number 100!
#------------------------------------------------------------------------------
# SOLUTION: 648
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
using namespace std;

string mul(string, string);
string toString(int);
string fact(int);
int toInt(char);

int main(){
    string f = fact(100000);
    cout << f << endl;
    int sum = 0;
    for (int i = 0; i < f.length(); i++){
        sum += toInt(f[i]);
    }
    cout << sum << endl;
    return 0;
}

int toInt(char c){
    return c - '0';
}

string toString(int n){
    stringstream s;
    s << n;
    return s.str();
}

string fact(int n){
    string fact = "1";
    for (int i = 1; i <= n; i++){
        fact = mul(fact, toString(i));
    }
    return fact;
}

string mul(string a, string b){
    string nums[2] = {a, b};
    string sum = "";

    const int sLen = a.length() + b.length() - 1;

    unsigned int s[sLen];
    for (int i = 0; i < sLen; i++){
        s[i] = 0;
    }

    for (int j = a.length() - 1; j >= 0; j--){
        for(int i = b.length() - 1; i >= 0; i--){
            s[i+j] += toInt(nums[0][j]) * toInt(nums[1][i]);
        }
    }

    for (int i = sLen-1; i-1 >= 0 ; i--){
        if (s[i] <= 9) continue;
        s[i-1] += s[i] / 10;
        s[i] %= 10;
    }

    for (int i = 0; i < sLen; i++){
        if(s[i] == 0) continue;
            for (int j = i; j < sLen; j++){
                stringstream ss;
                ss << s[j];
                sum += ss.str();
            }
            break;
    }
    return sum;
}
