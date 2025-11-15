#include <iostream>
#include <cmath>

using namespace std;

class Point{
    float x,y;

public:
    void setX(float val);
    float getX() const;
    void setY(float val);
    float getY() const;
    void print() const;
    void printLn() const;
    float length() const;
};

void 
Point::print() const{
    cout << "[" << getX() << ", " << getY() << "]";
}

void
Point::printLn() const{
    this->print();
    cout << endl;
}

float
Point::length() const{
    return sqrt(getX()*getX()*getY()*getY());
}

void 
Point::setX(float val){
    x = val;
}

float 
Point::getX() const{
    return x;
}

void 
Point::setY(float val){
    y = val;
}

float 
Point::getY() const{
    return y;
}


int 
main(){
    Point a, b;
    a.setX(8);
    b.setY(20);
    cout << a.length();
    return 0;
}