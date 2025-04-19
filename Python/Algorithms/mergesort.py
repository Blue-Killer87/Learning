def merge(field, result, start, mid, end):
    i = start
    j = mid
 
    for k in range(start, end):
        if i<mid and (j>=end or field[i] <= field[j]):
            result[k] = field[i]
            i += 1
        else:
            result[k] = field[j]
            j += 1
 
def mergesort(field):
    result = field[:]
    lenght = len(field)
    step = 1
    print(field)
    while step <= lenght:
        for start in range(0,lenght, step*2):
            mid = min(start+step, lenght)
            end = min(start+2*step, lenght)
            merge(field,result, start, mid, end)
        field = result[:]
        step *= 2
    
    print(result)


X = [5,2,8,5,1,2,8,4,5,4,8,2,1]
 
 
mergesort(X)

 