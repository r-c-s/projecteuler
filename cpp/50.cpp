/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 50
#------------------------------------------------------------------------------
# The prime 41 can be written as the sum of six consecutive primes:
# 
# 41 = 2 + 3 + 5 + 7 + 11 + 13
# This is the longest sum of consecutive primes that adds to a prime below
# one-hundred.
#
# The longest sum of consecutive primes below one-thousand that adds to a
# prime, contains 21 terms, and is equal to 953.
#
# Which prime, below one-million, can be written as the sum of the most
# consecutive primes?
#------------------------------------------------------------------------------
# SOLUTION: 997651
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
#include <new>
using namespace std;

bool isPrime(int);
bool check(int);

const int N = 1000; 
int* primes = new int[N];

int main(){
	primes[0] = 2;
	int j = 1;
	for(int i = 3; j < N; i+=2){
		if(!isPrime(i)) continue;
		primes[j++] = i;
	}
	int largest = 0;
	int consecutives = 0;
	int sum = 0;
	for(int i = 0; i < N; i++){
		sum = 0;
		int j = 0;
		do{
			if(isPrime(sum) && j > consecutives){
				largest = sum;
				consecutives = j;
			}
			sum+=primes[i+j++];
		}while(sum < 1000000 && i+j < N);
	}
	cout << largest << endl;
	return 0;
}

bool isPrime(int n){
	if(n == 2) return true;
	if(n < 2 || n % 2 == 0) return false;
	for(int i = 3; i <= sqrt(n); i+=2){
		if(n % i == 0) return false;	
	}
	return true;
}
