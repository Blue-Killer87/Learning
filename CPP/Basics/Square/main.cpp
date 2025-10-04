#include <iostream>


int
main(){
    int side = 0;
    double square;
    
    do{
        std::cout << "Insert size of square's side (positive number):";
        std::cin >> side; 
    } while (side < 0);

    square = side*side;
    std::cout << square;
    return 0;
}
