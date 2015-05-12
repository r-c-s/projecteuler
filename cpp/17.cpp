/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 17
#------------------------------------------------------------------------------
# If the numbers 1 to 5 are written out in words: one, two, three, four, five, 
# then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out
# in words, how many letters would be used?
# 
# 
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
# forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
# 20 letters. The use of "and" when writing out numbers is in compliance with
# British usage.
#------------------------------------------------------------------------------
# SOLUTION: 21124
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

int wordLength(int);
int word(int);

int main(){
	int sum = 0;
	for(int i = 1; i <= 1000; i++){
		sum += wordLength(i);
	}
	cout << sum << endl;
	return 0;
}

int wordLength(int n){
	int s[] = {0, 0, 7, 8};
	int teen[] = {0, 0, 0, 0, 1, 0, 1, 1, 0, 1};
	int ty[] = {0, 0, 3, 1, 1, 1, 2, 2, 1, 2};
	int total = 0;
	int j = -1;
	for(int i = 1; i <= n; i*=10){
		int t = n%(i*10)/i;
		j++;
		if (t == 0) continue;
		total += word(t);
		total += s[j];
		if (i == 10){
			if (t == 1) total += teen[n%10];
			else total += ty[t];
		}
		if (i == 100 && (n % 100) > 0) total += 3;
	}
	return total;
}

int word(int n){
	string words[] = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
	return words[n].length();
}




