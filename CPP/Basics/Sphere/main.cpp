#include <iostream>
#include <cmath>
#include <cstdio>

#include "mathModule.cpp"

float r;

int
main(){
    std::cout << "Please enter the radius of sphere: ";
    std::cin >> r;
    s = surface(r);
    v = volume(r);
    printf("Surface = %f  Volume = %f", s, v);
}
