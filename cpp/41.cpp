/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 41
#------------------------------------------------------------------------------
# We shall say that an n-digit number is pandigital if it makes use of all
# the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital
# and is also prime.
#
# What is the largest n-digit pandigital prime that exists?
#------------------------------------------------------------------------------
# SOLUTION: 7652413
#------------------------------------------------------------------------------
*/
#include <iostream>
#include <cmath>
using namespace std;

void prevPermutation(int[], int);
void prev(int[], int, int);
bool isPrime(int);

int nums[] = {7, 6, 5, 4, 3, 2, 1};

int main(){
	int num;
	while(true){
		num = 0;
		for(int i = 0; i < 7; i++){
			num += nums[i]*pow(10,7-1-i);
		}
		if(isPrime(num)) break;
		prevPermutation(nums, 7);
	}
	cout << num << endl;
	return 0;
}

void prevPermutation(int a[], int i){
    int j = i--;
    prev(a, --i, j);
}

void prev(int a[], int i, int j){
    if(a[i] > a[i+1]){
        int save = j;
        while (a[i] < a[--j]);
        int temp = a[j];
        a[j] = a[i];
        a[i] = temp;
        j = --save;
        while(i+1 < j){
            temp = a[i+1];
            a[1+i] = a[j];
            a[j] = temp;
	    j--;i++;
        }
        return;
    }
    prev(a, --i, j);
}

bool isPrime(int n){
	if(n == 2) return true;
	if(n == 1 || n % 2 == 0) return false;
	for(int i = 3; i <= sqrt(n); i++){
		if(n % i == 0) return false;
	}
	return true;
}
