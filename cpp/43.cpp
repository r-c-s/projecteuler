/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 43
#------------------------------------------------------------------------------
# The number, 1406357289, is a 0 to 9 pandigital number because it is made up
# of each of the digits 0 to 9 in some order, but it also has a rather
# interesting sub-string divisibility property.
#
# Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we
# note the following:
#
# d2d3d4=406 is divisible by 2
# d3d4d5=063 is divisible by 3
# d4d5d6=635 is divisible by 5
# d5d6d7=357 is divisible by 7
# d6d7d8=572 is divisible by 11
# d7d8d9=728 is divisible by 13
# d8d9d10=289 is divisible by 17
# Find the sum of all 0 to 9 pandigital numbers with this property.
#------------------------------------------------------------------------------
# SOLUTION: 16695334890
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <cmath>
using namespace std;

int check();
void nextPermutation(int[], int);
void next(int[], int, int);

int nums[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
int primes[] = {2, 3, 5, 7, 11, 13, 17};
		
int main(){	
	long long sum = 0;
	for(int i = 0; i < 3628800; i++){
		if(check()){
			for(int l = 0; l < 10; l++){
				 sum += nums[l] * pow(10, 10-1-l);;
			}
		}
		nextPermutation(nums, 10);
	}
	cout << sum << endl;
	return 0;
}

int check(){
	int num = 0;
	for(int i = 1; i < 10; i++){
		num += nums[i]*pow(10, 10-1-i);
	}
	for(int j = 7; j > 0; j--){
		int p = pow(10, 10-j);
		int n = (num % p) / (p / 1000);
		if(n % primes[j-1] != 0) return 0;
	}
	return num;
}

void nextPermutation(int a[], int i){
    int j = i--;
    next(a, --i, j);
}

void next(int a[], int i, int j){
    if(a[i] < a[i+1]){
        int save = j;
        while (a[i] > a[--j]);
        int temp = a[j];
        a[j] = a[i];
        a[i] = temp;
        j = --save;
        while(i+1 <= j){
            temp = a[i+1];
            a[1+i++] = a[j];
            a[j--] = temp;
        }
        return;
    }
    next(a, --i, j);
}
