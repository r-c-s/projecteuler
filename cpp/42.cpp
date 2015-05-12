/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 42
#------------------------------------------------------------------------------
# The nth term of the sequence of triangle numbers is given by, tn = (n(n+1))/2;
# so the first ten triangle numbers are:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# By converting each letter in a word to a number corresponding to its
# alphabetical position and adding these values we form a word value. For
# example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word
# value is a triangle number then we shall call the word a triangle word.
#
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file
# containing nearly two-thousand common English words, how many are triangle
# words?
#------------------------------------------------------------------------------
# SOLUTION: 162
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <fstream>
using namespace std;

bool isTriangle(int);
int numberValue(string);

int main(){
	int i = 0;
	ifstream wordText;
	string oneWord;
	wordText.open("42_words.txt");
	if (wordText.is_open()){
		while (!wordText.eof()){
			getline(wordText, oneWord, ',');
			oneWord = oneWord.substr(1, oneWord.size()-2);
			if (isTriangle(numberValue(oneWord))) i++;
		}
	}
	cout << i << endl;
	return 0;
}

bool isTriangle(int n){
	int i = 0;
	int m = 0;
	while(m < n){
		i++;
		m = (i*(i+1))/2;
		if (n == m) return true;
	}
	return false;
}

int numberValue(string s){
	int val = 0;
	for(int i = 0; i < s.length(); i++){
		val += s[i]-64;
	}
	return val;
}



