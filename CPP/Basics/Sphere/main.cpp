#include <iostream>
#include <cmath>
#include <cstdio>
#include <stdlib.h>

#include "mathModule.cpp"

using namespace std;

float r;

void 
clear() {
    std::cout << "\x1B[2J\x1B[H";
}

void
printMenu() {
    cout << endl <<"Main Menu" << endl;
    cout << endl << "Choose an option: " << endl;
    cout << "(s) the surface of the sphere" << endl;
    cout << "(v) the volume of the sphere" << endl;
    cout << "(q) quit" << endl;
}

void 
eventLoop() {
    char c;
    do{
        clear();
        printMenu();
        cin >> c;

        if (c == 's'){
            cout << "Surface of sphere is: " << surface(c) << endl;
        }
        else if (c == 'v'){
            cout << "Volume of sphere is: " << volume(c) << endl;
        }
    } while(c!='q');
}

int
main() {
    eventLoop();
}
