#include <cmath>

float pi = 3.1416;
float s, v;


float
power(long long x, int n){
    float helper = 1;
    for(int i=1; i<=n; i++){
        helper = helper * x;
    }
    return helper;
}


float 
surface(float r){
    s = 4*pi*pow(r,2);
    return s;
}

float
volume(float r){
    v = (4/float(3))*pi*pow(r,3);
    return v;
}

