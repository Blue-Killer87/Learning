#include <cmath>
#include <iostream>

using namespace std;

class Point {
  float x, y;

public:
  void setX(float val);
  float getX() const;
  void setY(float val);
  float getY() const;
  void print() const;
  void printLn() const;
  float length() const;
};

Point::Point(float x0, float y0)::x(x0), y(y0) {
  cout << "Constructor" << endl;
  /*
  x = x0;
  y = y0;
  */
}

Point::~Point() { cout << "Destructor" << endl; }

void Point::print() const { cout << "[" << getX() << ", " << getY() << "]"; }

void Point::printLn() const {
  this->print();
  cout << endl;
}

float Point::length() const { return sqrt(getX() * getX() * getY() * getY()); }

void Point::setX(float val) { x = val; }

float Point::getX() const { return x; }

void Point::setY(float val) { y = val; }

float Point::getY() const { return y; }

int main() {
  Point a, b;
  a.setX(8);
  b.setY(20);
  cout << a.getX();
  return 0;
}
