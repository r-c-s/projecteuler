/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 36
#------------------------------------------------------------------------------
# The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
#
# Find the sum of all numbers, less than one million, which are palindromic in
# base 10 and base 2.
#
# (Please note that the palindromic number, in either base, may not include
# leading zeros.)
#------------------------------------------------------------------------------
# SOLUTION: 872187
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
using namespace std;

string reverse(string);
bool isPalindromicB10(int);
bool isPalindromicB2(int);
string toBinary(int);
string toString(int);

int main(){
	int sum = 0;
	for(int i = 1; i < 1000000; i++){
		if(isPalindromicB10(i) && isPalindromicB2(i)) sum += i;
	}
	cout << sum << endl;
	return 0;
}

string reverse(string s){
	string r = "";
	for(int i = s.length()-1; i >= 0; i--){
		r += s[i];
	}
	return r;
}

bool isPalindromicB10(int n){
	return toString(n) == reverse(toString(n));
}

bool isPalindromicB2(int n){
	return toBinary(n) == reverse(toBinary(n));
}

string toString(int n){
	stringstream s;
	s << n;
	return s.str();
}

string toBinary(int n){
	string b = "";
	while(n > 0){
		if(n % 2 == 1) b+= "1";
		else b += "0";
		n /= 2;
	}
	return b;
}


