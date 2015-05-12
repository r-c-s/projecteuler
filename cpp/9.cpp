/*
#------------------------------------------------------------------------------
# PROJECT EULER
# PROBLEM 9
#------------------------------------------------------------------------------
# A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,
#
# a2 + b2 = c2
# For example, 32 + 42 = 9 + 16 = 25 = 52.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.
#------------------------------------------------------------------------------
# SOLUTION: 31875000
#------------------------------------------------------------------------------
*/

#include <iostream>
using namespace std;

int main(){
    for (int i = 1; i < 500; i++)
        for (int j = i+1; j < 500; j++)
            for (int k = j+1; k < 500; k++)
                if (i*i + j*j == k*k)
                    if (i+j+k == 1000)
                        cout << i << " + " << j << " + " << k << " = 1000" << endl;
}
