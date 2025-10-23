#include <iostream>

void
printArray(int *a,int size){
    /*for(auto i = 0; i<=size; i++){
        std::cout << a[i] << std::endl;
    }*/

    for(int *ptr = a; ptr <= &a[size]; ptr++){
        std::cout << *ptr << std::endl;
    }
}

int
main(){

    int s;
    int *arr;
    std::cout << "Enter number of array elements: ";
    std::cin >> s;
    
    arr = new int[s]; // Alocate memory block of size s*sizeof(int) on heap
    for(auto i = 0; i<=s; i++){
        arr[i] = i;
        
    }
    printArray(arr, s);
    
    

    delete [] arr;
    arr = nullptr;


    return 0;

}