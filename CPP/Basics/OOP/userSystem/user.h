#ifndef USER_H
#define USER_H

#include <string>

class User {
protected:
  std::string name, surname;
  int uid;

public:
  User(std::string, std::string);
  ~User();
  std::string getName() const { return name; }
  std::string getSurname() const { return surname; }
  void setSurname(std::string s) { surname = s; }
  int getUid() const { return uid; }
  void print() const;
};

// Student is child of User
class Student : public User {
protected:
  int credits;
  ;

public:
  Student();
  ~Student();
  int getCredits() const { return credits; }
};

class Teacher : public User {
protected:
  int salary;

public:
  Teacher(std::string, std::string, int);
  ~Teacher();
  int getSalary() const { return salary; }
};

#endif
