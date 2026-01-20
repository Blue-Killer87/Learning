#include <iostream>

class Queue {
private:
    int* data;
    int capacity;
    int head; // index hlavičky
    int tail; // index místa kam se zapíše další push (konec fronty)
    int size;

public:
    // konstruktor
    Queue(int cap)
        : capacity(cap), head(0), tail(0), size(0)
    {
        data = new int[capacity];
    }

    // kopírovací konstruktor
    Queue(const Queue& other)
        : capacity(other.capacity), head(other.head),
          tail(other.tail), size(other.size)
    {
        data = new int[capacity];
        for (int i = 0; i < capacity; i++)
            data[i] = other.data[i];
    }

    // operátor přirazení
    Queue& operator=(const Queue& other) {
        if (this == &other)
            return *this;

        delete[] data;

        capacity = other.capacity;
        head = other.head;
        tail = other.tail;
        size = other.size;

        data = new int[capacity];
        for (int i = 0; i < capacity; i++)
            data[i] = other.data[i];

        return *this;
    }

    // destruktor
    ~Queue() {
        delete[] data;
    }

    // implementace funkcí
    bool 
    isEmpty() const{
        return size == 0;
    }

    bool 
    isFull() const{
        return size == capacity;
    }

    void 
    pushBack(int value){
        if (isFull()) {
            std::cerr << "Fronta je plná\n";
            return;
        }
        data[tail] = value;
        tail = (tail + 1) % capacity;
        size++;
    }

    void 
    popFront(){
        if (isEmpty()) {
            std::cerr << "Fronta je prázdná\n";
            return;
        }
        head = (head + 1) % capacity;
        size--;
    }

    int
    front() const{
        if (isEmpty()) {
            std::cerr << "Fronta je prázdná\n";
            return -1;
        }
        return data[head];
    }
};


// využití fronty (pro testování)
int 
main(){
    int N;
    std::cout << "Vložte kapacitu: ";
    std::cin >> N;

    Queue q(N);

    // naplnění fronty
    for (int i = 1; i <= N; i++)
        q.pushBack(i);

    // výpis a vyprázdnění
    while (!q.isEmpty()) {
        std::cout << q.front() << " ";
        q.popFront();
    }

    std::cout << "\n";
    return 0;
}
