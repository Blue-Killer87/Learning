#include <iostream>
#include "characters.h"
using namespace std;

void
printASCIITable(){

    char c;
    int code;

    for(int i =32; i < 256; i++){
        cout << "ASCII code " << i << " corresponding " 
        << (char)i << " character" << endl;
    }
   

};

bool
isLower(char c){
    return 'a' <= c && c <= 'z';
}

bool
isUpper(char c){
    return 'A' <= c && c <= 'Z';
}

bool
isDigit(char c){
    return '0' <= c && c <= '9';
}

bool
isLetter(char c){
    return isUpper(c) || isLower(c);
}

bool
isAlpha(char c){
    return isLetter(c) || isDigit(c);
}

bool
isHexDigit(char c){
    return isDigit(c)
        || ('a' <= c && c <= 'f')
        || ('A' <= c && c <= 'F');
}

char
toLower(char c){
    if (isUpper(c)){
        char delta = ('a' - 'A');
        return c + delta;
        }
    else{
        return 0;
    }
    }
    

char
toUpper(char c){
    if (isLower(c)){
        char delta = ('a' - 'A');
        return c - delta;
        }
    else{
        return 0;
    }
    }
    