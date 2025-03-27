MAX_CAPACITY = 10

class node:
    def __init__(self, key:str, data:any):
            self.key = key
            self.data = data

    def __str__(self):
        return f"{self.key}: {str(self.data)}"

class HashTable:
    def __init__(self):
        self.size = 0
        self.table = [None] * MAX_CAPACITY
        for i in range(MAX_CAPACITY):
            self.table[i] = []

    def hash(self, key:str) -> int:
        return len(key)%MAX_CAPACITY

    def hash2(self, key:str) -> int:
        result = 0
        random = 0
        for i in key:
            result += ord(i)
            #random = random.randint()
        return (result) % MAX_CAPACITY

    def hash3(self, key:str) -> int:
        hashsum = 0
        for idx, c in enumerate(key):
            hashsum += (idx+len(key))**ord(c)
            hashsum = hashsum%MAX_CAPACITY

    def insert(self, key:str, data:any) -> bool:
        index = self.hash(key)
        for x in self.table[index]:
            if x.key == key:
                return False
        self.table[index].append(node(key, data))
        self.size += 1

    def find(self, key:str):
        index = self.hash(key)
        data = self.table[index]
        for i in data:
            if i.key == key:
                return(i)
        return(None)

    def remove(self, key:str):
        index = self.hash(key)
        data = self.table[index]
        iteration = 0
        for i in data:
            if i.key == key:
                self.table[index][iteration] = ""
                self.size -= 1
            iteration += 1

                
    def __str__(self):
        result = ""
        for i in range(MAX_CAPACITY):
            result += f"{i}: "
            for x in self.table[i]:
                result += str(x)+ " "
            result += "\n"
        return result


h = HashTable()
h.insert("sdfd", 20)
h.insert("dfsf", 10)

h.insert("bcbvbc", 30)
h.insert("dfdfgdsf", 40)
h.insert("tertr", 50)
h.insert("djhnhgfsf", 60)
print(h)
h.remove("dfsf")
print(h)

#print(h.find("dfsf"))

