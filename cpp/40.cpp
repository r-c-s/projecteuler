/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 40
#------------------------------------------------------------------------------
# An irrational decimal fraction is created by concatenating the positive
# integers:
#
# 0.123456789101112131415161718192021...
#
# It can be seen that the 12th digit of the fractional part is 1.
#
# If dn represents the nth digit of the fractional part, find the value of
# the following expression.
#
# d1  d10  d100  d1000  d10000  d100000  d1000000
#------------------------------------------------------------------------------
# SOLUTION: 210
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
using namespace std;

int main(){
	stringstream ss;
	int i = 1;
	while(ss.str().length() < 1000000){
		ss << i++;
	}
	string s = ss.str();
	int total = 1;
	for(int i = 1; i <= 1000000; i*=10){
		total *= s[i-1] - '0';
	}

	cout << total << endl;
	return 0;
}
