from random import *
import math
import time

############################################################

x = time.time()*100000
intx = int(x)

cypher = x - intx
cypher = int(round(cypher, 2)*100)

############################################################

class EntropyGen():
    def __init__(self):
        self.timeList = []
        self.cypherList = []
        self.digits = []
        self.smallDigits = []
        self.finaldigit = 0
        self.singleDigit = 0
        self.superlist = []

    def timeConverter(self, mult=1):
        for i in range(69):
            x = time.time()*100000
            intTime = int(x)
            totalTime = x-intTime*mult
            self.timeList.append(totalTime)

        self.delta = int(round(time.time(), 0))
        while self.delta > 69:
            self.delta = int(round(self.delta/5,0)) 
    
    def cypherTime(self):
        self.timeConverter()
        for i in self.timeList:
            self.cypherList.append(int(round(i,2)*100))
        
        for i in self.cypherList:
            if i%2:
                self.digits.append(i)
            elif i%3:
                self.digits.append(int(round(i/3,0)))      
            
    def Randomize(self):
        self.cypherTime()
        for i in self.digits:
            if i>10:
                i = int(round(i/10))
                self.smallDigits.append(i)
        self.finaldigit = self.smallDigits[self.delta]
        self.randomNum = self.smallDigits[self.finaldigit]
        return self.randomNum        
randomized = []
R = 1
for i in range(R):
    try:
        randomized.append(EntropyGen().Randomize())
    except:
        pass

print(randomized)
random_len = len(randomized)
#print(f"Weird errors: {R-random_len}")

i=0
offset_error = 0
while i < random_len-1:  
    if randomized[i] == randomized[i+1]:
        offset_error += 1
        i += 1
    else:
        i += 1
'''print(f"Number of numbers: {random_len}")
print(f"Number of same numbers following each other: {offset_error}")
print(f"Percentage of randomness: {(random_len-offset_error)/random_len*100}%")'''

        