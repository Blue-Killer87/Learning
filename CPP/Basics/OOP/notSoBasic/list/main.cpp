#include <iostream>

typedef int Data;

class Item {
  Data payload;
  Item *prev;
  Item *next;

public:
  Item();
  Item(Data d);
  void setData(Data d) { payload = d; }
  Data getData() const { return payload; }
  void print() const;
  void printLn() const;
};

Item::Item() : prev(nullptr), next(nullptr) {}

Item::Item(Data d) : prev(nullptr), next(nullptr) {}

void Item::print() const { std::cout << payload; }

void Item::printLn() const {}

class List {
  Item *first;
  Item *last;
  int counter;

public:
  List();
};

List::List() : first(new Item()), last(new Item()), counter(0) {
  first->next = last;
  last->prev = fisrt;
}
