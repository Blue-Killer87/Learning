def bubblesort(field):
    start = 0
    result = field[:]
   
    for iteration in range(len(field)):
        for i in range(0, len(field)-1):
            if  result[start] > result[start+1]:
                result[start], result[start+1] = result[start+1], result[start]               
            start+=1
        start = 0
    print(result)



field = [5,2,8,5,1,2,8,4,5,4,8,2,1]
print(field)
bubblesort(field)