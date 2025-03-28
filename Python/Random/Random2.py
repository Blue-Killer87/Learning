import time

class Random():
    def __init__(self):
        self.length = 1
        self.value = 1
        self.iteration = 0
        self.random = 0
        self.time = time.time()
        self.randomList = []
        self.previous = 0
        self.TotalSame = 0
    def getRandom(self, length):
        while len(self.randomList) != self.length:
            self.length = length
            self.modulator = self.length*69
            self.EntropyGen()
            while self.iteration < 5*len(self.randomList):
                self.EntropyGen()

            
            self.assignNumber()
        return self.randomList, self.TotalSame

    def EntropyGen(self):
        self.value += 1
        self.value += self.value%self.modulator
        self.iteration += 1
        return 

        

    def assignNumber(self):
        self.previous = self.random
        self.random = (self.value*self.length*self.time)%10
        self.random = int(round(self.random, 0))
        if self.previous == self.random:
            self.TotalSame += 1
        if self.random < 0:
            self.random *= -1
        self.randomList.append(self.random)
        self.iteration = 0
        return


length = int(input('Set how many random numbers you want: '))
random = Random().getRandom(length)

print(f"Random numbers: {random[0]}")
print(f"\n\nAmount of numbers: {length}")
print(f"Amount of duplicate numbers: {random[1]}")
print(f"Percentage of randomness: {100-(random[1]/length)*100}")



    