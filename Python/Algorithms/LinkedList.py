class Node:
    def __init__(self, next, data):
        self.next = next
        self.data = data

    def __str__(self):
        return str(self.data)
    

class LinkedList:
    def __init__(self):
        self.head = Node(None, None)
        self.tail = self.head
        self.size = 0

    def add_at_begin(self, d):
        tmp = self.head
        self.head = Node(tmp, d)
        self.size += 1

    def __str__(self):
        tmp = self.head
        result = "["
        while tmp != self.tail:
            result += str(tmp)
            tmp = tmp.next
            if tmp != self.tail:
                result += ", "
        return result + "]"
    
    def append(self, d):
        self.tail.data = d
        self.tail.next = Node(None, None)
        self.tail = self.tail.next
        self.size += 1

    def find(self, d) -> Node:
        tmp = self.head
        self.tail.data = d
        while tmp.data != d:
            tmp = tmp.next
        if tmp==self.tail:
            return None
        else:
            return tmp
        
    def add(self, node:Node, d):
        if node==self.tail:
            raise Exception("Vlozeni za zarazku")
        node.next = Node(node.next, d)
        self.size += 1

    def delete(self, node:Node):
        if node==self.tail:
            raise Exception("Mazani zarazky")
        if node.next == self.tail:
            self.tail = node
            node.next = None
        else:
            node.data = node.next.data
            node.next = node.next.next
        self.size -= 1

    def delete_index(self, index:int):
        tmp = self.head
        k = 0
        if index>=self.size:
            raise Exception("Spatny index")
        while k<index:
            tmp = tmp.next
            k += 1

        self.delete(tmp)

    def selectionSort(self):
        pointer = self.head
        result = [0 for i in range(self.size)]
        for i in range(self.size):
            for n in range(self.size-1):
                if pointer == self.tail:
                    return result
                if pointer.data > pointer.next.data:
                    result[n], result[n+1] = pointer.next.data, pointer.data
                else:
                    result[n], result[n+1] = pointer.data, pointer.next.data
        return(result)
                
                




seznam = LinkedList()
print(seznam)

seznam.add_at_begin(5)
seznam.add_at_begin(2)
seznam.add_at_begin(6)
seznam.add_at_begin(10)
print(seznam)

print(seznam.selectionSort())
