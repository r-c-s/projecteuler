/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 38
#------------------------------------------------------------------------------
# Take the number 192 and multiply it by each of 1, 2, and 3:
#
# 192  1 = 192
# 192  2 = 384
# 192  3 = 576
# By concatenating each product we get the 1 to 9 pandigital, 192384576.
# We will call 192384576 the concatenated product of 192 and (1,2,3)
#
# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4,
# and 5, giving the pandigital, 918273645, which is the concatenated product
# of 9 and (1,2,3,4,5).
#
# What is the largest 1 to 9 pandigital 9-digit number that can be formed as
# the concatenated product of an integer with (1,2, ... , n) where n > 1?
#------------------------------------------------------------------------------
# SOLUTION: 932718654
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
#include <cmath>
using namespace std;

bool isPandigital(string, int, int);
int toInt(string);
int toInt(char);

int main(){
	int largest = 0;
	for(int i = 9; i <= 10000; i++){
		int j = 1;
		stringstream t;
		while(t.str().length() < 9) t << i*j++;
		if(t.str().length() > 9) continue;
		if(!isPandigital(t.str(), 1, 9)) continue;
		if(toInt(t.str()) > largest) largest = toInt(t.str());
	}
	cout << largest << endl;
	return 0;
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

int toInt(string s){
	stringstream ss(s);
	int n = 0;
	ss >> n;
	return n;
}

int toInt(char c){
	return c - '0';
}
