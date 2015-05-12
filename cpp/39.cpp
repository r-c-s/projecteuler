/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 39
#------------------------------------------------------------------------------
# If p is the perimeter of a right angle triangle with integral length sides,
# {a,b,c}, there are exactly three solutions for p = 120.
#
# {20,48,52}, {24,45,51}, {30,40,50}
#
# For which value of p  1000, is the number of solutions maximised?
#------------------------------------------------------------------------------
# SOLUTION: 840
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

int numberOfSolutions(int);

int main(){
	int max = 0;
	int maxVal = 0;

	for(int p = 1; p <= 1000; p++){
		int m = numberOfSolutions(p);
		if (m > max) { max = m; maxVal = p; }
	}

	cout << maxVal << endl;
	return 0;
}

int numberOfSolutions(int n){
	int count = 0;
	for(int a = 1; a < n/2; a++){
		for(int b = a; b < n/2; b++){
			double c = sqrt(a*a+b*b);
			if (a+b+c == n) count++;
		}
	}
	return count/2;
}

