/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 49
#------------------------------------------------------------------------------
# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms
# increases by 3330, is unusual in two ways: (i) each of the three terms are
# prime, and, (ii) each of the 4-digit numbers are permutations of one another.
#
# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
# exhibiting this property, but there is one other 4-digit increasing sequence.
#
# What 12-digit number do you form by concatenating the three terms in this
# sequence?
#------------------------------------------------------------------------------
# SOLUTION: 296962999629
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <sstream>
#include <cmath>
#include <new>
using namespace std;

bool isPrime(int);
bool arePermutationsOfOneAnother(int, int, int);
int permutationOf(int);
int toInt(char);

int main(){
	for(int i = 1001; i < 10000; i+=2){
		int j = i+3330;
		int k = j+3330;
		if(!isPrime(i) || !isPrime(j) || !isPrime(k)) continue;
		if(arePermutationsOfOneAnother(i, j, k)) 
			cout << i << j << k << endl;	
	}
	return 0;
}

bool arePermutationsOfOneAnother(int i, int j, int k){
	return permutationOf(i) == permutationOf(j) && permutationOf(j) == permutationOf(k);
}

int permutationOf(int n){
	int count[10];
	for(int i = 0; i < 10; i++) 
		count[i] = 0;

	stringstream s;
	s << n;
	for(int i = 0; i < s.str().length(); i++)
		count[toInt(s.str()[i])]++;

	int r = 0;
	for(int i = 0; i < 10; i++)
		for(int j = 0; j < count[i]; j++) r = r * 10 + i;

	return r;
}

bool isPrime(int n){
	if(n < 2) return false;
	if(n == 2) return true;
	if(n % 2 == 2) return false;
	for(int i = 3; i <= sqrt(n); i++){
		if(n % i == 0) return false;	
	}
	return true;
}

int toInt(char c){
	return c - '0';
}
