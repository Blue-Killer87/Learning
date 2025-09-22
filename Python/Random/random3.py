import math
import numpy
import time

#print(time.time())

def RandomNumber(input=5):
    random = 0
    for i in range(0, input):
        timer = (time.time())*100000
        timer =round((timer - int(timer))*100)
        modular = modulate(timer)
        random += modular
    random = random%1000
    return random

def modulate(input=1):
    
    for i in range(int(input)):
        (i*input%2)//10
        input=i
    return input
testTotal = []

for i in range(5):
    tests = 10000
    random = -1
    testcase = []
    duplicate = 0
    for i in range(tests):
        lastrandom = random
        random = RandomNumber()
        if random == lastrandom:
            duplicate += 1
        testcase.append(random)
        print(random, end=" ")
    print(f"\n\nNumber of testcases: {tests}\nNumber of duplicates: {duplicate}\nTotal randomness: {100-(duplicate/tests*100)}%")
    testTotal.append(100-(duplicate/tests*100))

overallperc = 0
for i in testTotal:
    overallperc += i
print(f"Total mean randomness: {overallperc/5}%")


