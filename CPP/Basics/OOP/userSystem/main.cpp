#include <iostream>

#include "user.h"

using namespace std;

int generateUid() {
  // W.I.P
  return 42;
}

User::User(string _name, string _surname)
    : name(_name), surname(_surname), uid(generateUid()) {
  cout << "Creating user\n";
}

User::~User() { cout << "Removing user\n"; }

void User::print() const {
  cout << "Role: user\n";
  cout << "Name: " << name << "\n";
  cout << "Surname: " << surname << "\n";
  cout << "Id: " << uid << endl;
}

Student::Student(string _name, string _surname)
    : User(_name, _surname), credits(0) {

  cout << "Creating student\n";
}

Student::~Student() { cout << "Removing student\n"; }

Teacher::Teacher(string _name, string _surname, int _salary)
    : User(_name, _surname),
      salary(_salary){

          cout << "Creating teacher\n";
      }

      Teacher::~Teacher() {
  cout << "Removing teacher\n";
}

int main() {
  User u("John", "Doe");
  u.print();
  return 0;
}
