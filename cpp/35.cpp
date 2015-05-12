/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 35
#------------------------------------------------------------------------------
# The number, 197, is called a circular prime because all rotations of the 
# digits: 197, 971, and 719, are themselves prime.
#
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
# 71, 73, 79, and 97.
#
# How many circular primes are there below one million?
#------------------------------------------------------------------------------
# SOLUTION: 55
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

bool isPrime(int);
bool can(int);

int main(){
	int count = 1; //the number 2
	for(int i = 3; i < 1000000; i+=2){
		if(isPrime(i) && can(i)) count++;
	}
	cout << count << endl;
	return 0;
}

bool isPrime(int n){
	if(n == 2) return true;
	if(n == 1 || n % 2 == 0) return false;
	for(int i = 3; i <= sqrt(n); i++){
		if(n % i == 0) return false;
	}
	return true;
}

bool can(int n){
	int m = n;
	int p = 1;
	while(p <= n/10) p*=10;
	do {
		int r = m%10;
		m /= 10;
		m += r*p;
		if(!isPrime(m)) return false;
	} while(m != n);
	return true;
}
