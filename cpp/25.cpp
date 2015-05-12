/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 25
#------------------------------------------------------------------------------
# The Fibonacci sequence is defined by the recurrence relation:
# 
# Fn = Fn1 + Fn2, where F1 = 1 and F2 = 1.
# Hence the first 12 terms will be:
# 
# F1 = 1
# F2 = 1
# F3 = 2
# F4 = 3
# F5 = 5
# F6 = 8
# F7 = 13
# F8 = 21
# F9 = 34
# F10 = 55
# F11 = 89
# F12 = 144
# The 12th term, F12, is the first term to contain three digits.
# 
# What is the first term in the Fibonacci sequence to contain 1000 digits?
#------------------------------------------------------------------------------
# SOLUTION: 4782
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
using namespace std;

string add(string, string);

int main(){
    string prev = "1";
    string next = "0";
    string save = "0";
    int index = 0;
    while(next.length() < 1000){
        save = add("0", prev);
        prev = add("0", next);
        next = add(next, save);
        index++;
    }
    cout << index << endl;
    cout << next << endl;
    return 0;
}

string add(string a, string b){
    string nums[2] = {a, b};
    string sum = "";

    int len = a.length();
    if (a.length() < b.length()) len = b.length();

    const int sLen = len+1;
    unsigned int s[sLen];
    for (int i = 0; i < sLen; i++) s[i] = 0;

    for (int j = 0; j < len; j++){
        for(int i = 0; i < 2; i++){
            int index = nums[i].length()-1-j;
            if (index < 0) continue;
            s[sLen-1-j] += nums[i][index] - '0';
        }
    }

    for (int i = sLen-1; i > 0; i--){
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
