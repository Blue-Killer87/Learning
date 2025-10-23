#include <iostream>

bool
isDigit(char c){
    return '0' <= c && c <= '9';
}

int
char2Digit(char c){
    if(isDigit(c)){
        return c - '0';
    }
    else{
        return -1;
    }

}

int

digitSum(int i, int sum){
    return sum*10 + i;
}

int
str2int(char *str){
    int res = 0;
    int idx = 0;
    int digit;
    while(str[idx]!='\0'){
        std::cout << str[idx] << std::endl;
        idx++;
    }
    return res;
}

void
printInput(int *arr,int size){
    for(int *ptr = arr; ptr <= &arr[size]; ptr++){
        std::cout << *ptr << std::endl;
    }
}
int
main(int argc, char *argv[]){
    int sum = 0;

    if(argc!=2){
        std::cerr << "Wrong usage! You need to specify two arguments.";
        return 1;
    }

    L = str2int(argv[1]);
    for(int i = 0; i < argc; i++){
        sum = digitSum(*argv[i], sum);
    }
    std::cout << "Glued numbers: " << sum << std::endl;
    int i = str2int(argv[1]);
}