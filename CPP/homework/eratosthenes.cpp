#include <iostream>
#include <cstdlib>   
#include <cmath>   
  
using namespace std;


//vytvoření a inicializaci síta
bool* 
vytvorSito(int N) {
    bool* sito = new bool[N + 1]; // index
    for (int i = 0; i <= N; i++) {
        sito[i] = true; // vše jnejprve označeno za nevyškrtnuté
    }
    //vyškrtneme 0 a 1
    if (N >= 0) sito[0] = false;
    if (N >= 1) sito[1] = false;
    return sito;
}

// Eratosthenovo síto
void 
eratosthenes(bool* sito, int N) {
    for (int i = 2; i * i <= N; i++) {
        if (sito[i]) {
            for (int j = i * i; j <= N; j += i) {
                sito[j] = false;
            }
        }
    }
}

// výpis prvočísel a jejich počet
void 
vypisPrvocisla(bool* sito, int N) {
    int pocet = 0;
    for (int i = 2; i <= N; i++) {
        if (sito[i]) {
            cout << i << " ";
            pocet++;
        }
    }
    cout << endl << pocet << endl;
}


int 
main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Chyba: Zadejte jedno cislo N jako parametr." << endl;
        return 1;
    }

    char* endptr = nullptr;
    long N = strtol(argv[1], &endptr, 10);
    if (*endptr != '\0' || N < 2) {
        cerr << "Chyba: Neplatne cislo N." << endl;
        return 1;
    }

    bool* sito = vytvorSito(N);
    eratosthenes(sito, N);
    vypisPrvocisla(sito, N);

    delete[] sito;
    return 0;
}
