/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 19
#------------------------------------------------------------------------------
# You are given the following information, but you may prefer to do some
# research for yourself.
#
# 1 Jan 1900 was a Monday.
# Thirty days has September,
# April, June and November.
# All the rest have thirty-one,
# Saving February alone,
# Which has twenty-eight, rain or shine.
# And on leap years, twenty-nine.
# A leap year occurs on any year evenly divisible by 4, but not on a century
# unless it is divisible by 400.
# How many Sundays fell on the first of the month during the twentieth century
# (1 Jan 1901 to 31 Dec 2000)?
#------------------------------------------------------------------------------
# SOLUTION: 171
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

void testForLeap(int);

int totalDays[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
int beginYear = 1901;
int endYear = 2000;
int length = endYear - beginYear + 1;
int fd[length][12];
int sundays = 0;

int main(){
    for (int i = 0; i < length; i++){
        fd[i][0] = i + 3;
        if (fd[i][0] > 4){
            fd[i][0] += (fd[i][0] - 3) / 4;
        }
        if (fd[i][0] > 7){
            fd[i][0] %= 7;
        }
        if (fd[i][0] == 0){
            fd[i][0] = 7;
        }
        testForLeap(1901+i);
        for (int j = 1; j < 12; j++){
            fd[i][j] = (fd[i][j-1] + totalDays[j-1]) % 7;
            if (fd[i][j] == 0){
                fd[i][j] = 7;
            }
        }
    }

    for (int i = 0; i < length; i++){
        for (int j = 0; j < 12; j++){
            if (fd[i][j] == 1){
                sundays++;
            }
        }
    }

    cout << sundays;
}

void testForLeap(int year) {
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        totalDays[1] = 29;
    }
    else {
        totalDays[1] = 28;
    }
}
