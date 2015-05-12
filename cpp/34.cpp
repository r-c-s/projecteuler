/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 34
#------------------------------------------------------------------------------
# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#
# Find the sum of all numbers which are equal to the sum of the factorial
# of their digits.
#
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.
#------------------------------------------------------------------------------
# SOLUTION: 40730
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
using namespace std;

int factorial(int);
int toInt(char);

int main(){
	int sum = 0;
	for(int i = 3; i < 50000; i++){
		stringstream s;
		s << i;
		int t = 0;
		for(int j = 0; j < s.str().length(); j++){
			t += factorial(toInt(s.str()[j]));
		}
		if(t == i){
			cout << t << " = " << i << endl;
			sum += t;
		}	
	}
	cout << sum << endl;
	return 0;
}
 
int factorial(int n){
	int f = 1;
	for(int i = 2; i <= n; i++){
		f *= i;
	}
	return f;
}

int toInt(char c){
	return c - '0';
}
