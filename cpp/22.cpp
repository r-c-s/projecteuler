/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 22
#------------------------------------------------------------------------------
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file 
# containing over five-thousand first names, begin by sorting it into 
# alphabetical order. Then working out the alphabetical value for each name, 
# multiply this value by its alphabetical position in the list to obtain a name 
# score.
# 
# For example, when the list is sorted into alphabetical order, COLIN, which is 
# worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN 
# would obtain a score of 938  53 = 49714.
#
# What is the total of all the name scores in the file?
#------------------------------------------------------------------------------
# SOLUTION: 871198282
#------------------------------------------------------------------------------
*/

#include <iostream>
#include <fstream>
using namespace std;

long unsigned value(string[]);
void sort(string[]);
void sort(string[], string[], int, int);
void merge(string[], string[], int, int, int);
void exch(string[], int, int);

string names[5163];
int sum[5163];

int main(){
    string oneName;
    ifstream nameText;
	
    nameText.open("22_names.txt");
    if (nameText.is_open()){
        int i = 0;
        while (!nameText.eof()){
            getline(nameText, oneName, ',');
            names[i] = oneName.substr(1, oneName.size()-2);
            i++;
        }
    }
    sort(names);
    cout << value(names);
}

long unsigned value(string s[]){
    long unsigned sum = 0;
    int sumOfName = 0;
    for (int i = 0; i < 5163; i++){
        sumOfName = 0;
        for (int j = 0; j < s[i].length(); j++){
            int k = s[i][j] - 64;
            sumOfName += k;
        }
        sum += (i+1) * sumOfName;
    }
    return sum;
}

void sort(string a[]) {
    const int N = 5163;
    string aux[N];
    sort(a, aux, 0, N-1);
}

void sort(string a[], string aux[], int lo, int hi) {
    if (hi <= lo) return;
    int mid = (lo + hi) / 2;
    sort(a, aux, lo, mid);
    sort(a, aux, mid+1, hi);
    merge(a, aux, lo, mid, hi);
}

void merge(string a[], string aux[], int lo, int mid, int hi) {
    // copy region to aux array
    for (int i=lo; i<=hi; i++) {
        aux[i] = a[i];
    }
    // merge the two sorted subregions back into the input array
    int i = lo;
    int j = mid+1;
    for (int k=lo; k<=hi; k++) {
        if      (hi <j)            a[k] = aux[i++];
        else if (mid<i)            a[k] = aux[j++];
        else if (aux[j] < aux[i])      a[k] = aux[j++];
        else                       a[k] = aux[i++];
    }
}

void exch(string a[], int i, int j) {
    string t = a[i];
    a[i] = a[j];
    a[j] = t;

}
