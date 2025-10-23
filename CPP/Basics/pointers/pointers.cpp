#include <iostream>

int
main(){
    int i;
    int *ptr1;
    ptr1 = &i;
    *ptr1 = 42;

    std::cout << i;
}