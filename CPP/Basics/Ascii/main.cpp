#include <iostream>
#include "characters.h"
#include "main_iter.cpp"
using namespace std;

int 
main(){
    char c;
    cout << "Enter value to check: ";
    cin >> c;
    //printASCIITable();
    cout << "Lower: " << isLower(c) << endl;
    cout << "Upper: " << isUpper(c) << endl;
    cout << "Digit: " << isDigit(c) << endl;
    cout << "Letter: " << isLetter(c) << endl;
    cout << "Alphanumerical: " << isAlpha(c) << endl;

    cout << "Lowercase: " << toLower(c) << endl;
    cout << "Uppercase: " << toUpper(c);
}



