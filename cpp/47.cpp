/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 47
#------------------------------------------------------------------------------
# The first two consecutive numbers to have two distinct prime factors are:
# 
# 14 = 2 x 7
# 15 = 3 x 5
#
# The first three consecutive numbers to have three distinct prime factors are:
#
# 644 = 2² x 7 x 23
# 645 = 3 x 5 x 43
# 646 = 2 x 17 x 19.
# 
# Find the first four consecutive integers to have four distinct primes
# factors. What is the first of these numbers?
#------------------------------------------------------------------------------
# SOLUTION: 134043
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <new>
#include <cmath>
using namespace std;

bool hasFourDistinctPrimeFactors(int);
bool isPrime(int);

const int N = 1000;
bool* prime = new bool[N];

int main(){
	for(int i = 0; i < N; i++){
		prime[i] = isPrime(i);
	}
	int step = 1;
	for(int i = 645; true; i+=step){
		if(prime[i]) continue;
		step = 1;
		if(hasFourDistinctPrimeFactors(i)){
			step = 2;
			if(hasFourDistinctPrimeFactors(i+1)){
				step = 3;
				if(hasFourDistinctPrimeFactors(i+2)){
					step = 4;
					if(hasFourDistinctPrimeFactors(i+3)){
						cout << i << endl;
						return 0;
					}
				}
			}
		}
	}
}

bool hasFourDistinctPrimeFactors(int n){
	for(int i = 2; i*i < n; i++){
		if(!prime[i] || n % i != 0) continue;
		for(int j = i+1; i*j*j < n; j++){
			if(!prime[j] || n % j != 0) continue;
			for(int k = j+1; i*j*k*k < n; k++){
				if(!prime[k] || n % k != 0) continue;
				for(int l = k+1; i*j*k*l <= n; l++){
					if(!prime[l] || n % l != 0) continue;
					return true;
				}
			}
		}
	}
	return false;
}

bool isPrime(int n){
	if(n < 2) return false;
	if(n == 2) return true;
	if(n % 2 == 0) return false;
	for(int i = 3; i <= sqrt(n); i++){
		if(n % i == 0) return false;
	}
	return true;
}
