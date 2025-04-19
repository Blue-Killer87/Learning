def quicksort(field, start:int, end:int):
    result=field[:]
    pivot_index = (start+end)//2
    pivot = field[pivot_index]
    print(f'pivot is {pivot}')
    while start < pivot_index-1:
        if field[start] < pivot and start < pivot_index:
             start += 1
        elif field[start] > pivot and start > pivot_index:
            start += 1
        elif field[start] < pivot and start > pivot_index:
            field[pivot_index-start+1] =field[start]
            start += 1
        elif field[start] > pivot and start < pivot_index:
            result[pivot_index+start+1] = field[start]
            start += 1
        else:
            start += 1

        print(result)   

    




X = [5,2,8,5,1,2,8,4,5,4,8,2,1,3]
print(X)
quicksort(X, 0, len(X))