/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 31
#------------------------------------------------------------------------------
# In England the currency is made up of pound, £, and pence, p, and there are
# eight coins in general circulation:
#
# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:
#
# 1£1 + 150p + 220p + 15p + 12p + 31p
# How many different ways can £2 be made using any number of coins?
#------------------------------------------------------------------------------
# SOLUTION: 73682
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

int main(){
    int count = 0;
    for(int a = 1; a >= 0; a--)
        for(int b = (200-(200*a))/100; b >= 0; b--)
            for(int c = (200-((100*b)+(200*a)))/50; c >= 0; c--)
                for(int d = (200-((50*c)+(100*b)+(200*a)))/20; d >= 0; d--)
                    for(int e = (200-((20*d)+(50*c)+(100*b)+(200*a)))/10; e >= 0; e--)
                        for(int f = (200-((10*e)+(20*d)+(50*c)+(100*b)+(200*a)))/5; f >= 0; f--)
                            for(int g = (200-((5*f)+(10*e)+(20*d)+(50*c)+(100*b)+(200*a)))/2; g >= 0; g--){
                                int h = (200-((2*g)+(5*f)+(10*e)+(20*d)+(50*c)+(100*b)+(200*a)))/1;
                                    count++;
                            }
    cout << count;
}
