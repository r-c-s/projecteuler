/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 46
#------------------------------------------------------------------------------
# It was proposed by Christian Goldbach that every odd composite number can
# be written as the sum of a prime and twice a square.
#
# 9 = 7 + 212
# 15 = 7 + 222
# 21 = 3 + 232
# 25 = 7 + 232
# 27 = 19 + 222
# 33 = 31 + 212
#
# It turns out that the conjecture was false.
#
# What is the smallest odd composite that cannot be written as the sum of a
# prime and twice a square?
#------------------------------------------------------------------------------
# SOLUTION: 5777
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <new>
#include <cmath>
using namespace std;

bool isOdd(int);
bool isPrime(int);
bool isComposite(int);
bool check(int);

const int N = 10000;
bool* composite = new bool[N];

int main(){
	for(int i = 0; i < N; i++){
		composite[i] = isComposite(i);
	}
	for(int i = 2; i < N; i++){
		if (!composite[i] || !isOdd(i)) continue;
		if (!check(i)) { 
			cout << i << endl; 
			break;
		}
	}
	return 0;
}

bool isOdd(int n){
	return n % 2 == 1;
}

bool isComposite(int n){
	if(n <= 3) return false;
	return !isPrime(n);
}

bool isPrime(int n){
	if(n % 2 == 0) return false;
	if(n < 2) return false;
	for(int i = 3; i <= sqrt(n); i++){
		if(n % i == 0) return false;
	}
	return true;
}

bool check(int n){
	int check;
	for(int i = 2; i < N; i++){
		if (composite[i]) continue;
		check = 0;
		for(int j = 1; check <= n; j++){
			check = i+2*(j*j);
			if(check == n) return true;
		}
	}
	return false;
}
