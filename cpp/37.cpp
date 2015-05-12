/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 37
#------------------------------------------------------------------------------
# The number 3797 has an interesting property. Being prime itself, it is
# possible to continuously remove digits from left to right, and remain prime
# at each stage: 3797, 797, 97, and 7. Similarly we can work from right to
# left: 3797, 379, 37, and 3.
#
# Find the sum of the only eleven primes that are both truncatable from left
# to right and right to left.
#
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
#------------------------------------------------------------------------------
# SOLUTION: 748317
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

bool is(int);
bool isPrime(int);

int main(){
	int sum = 0;
	int count = 0;
	for(int i = 11; count < 11; i+=2){
		if(is(i)) {sum+=i; count++;}
	}
	cout << sum << endl;
	return 0;
}

bool is(int n){
	//from left:
	int copy = n;
	while(copy > 0){
		if(!isPrime(copy)) return false;
		copy /= 10;
	}
	//from right;
	copy = n;
	int p = 1;
	while(p*10 <= n) p*=10;
	while(copy > 0){
		if(!isPrime(copy)) return false;
		copy -= copy/p * p;
		p/=10;
	}
	return true;
}

bool isPrime(int n){
	if(n == 2) return true;
	if(n == 1 || n % 2 == 0) return false;
	for(int i = 3; i <= sqrt(n); i++){
		if(n % i == 0) return false;
	}
	return true;
}
