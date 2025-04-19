# From lowest to highest
def selectionSort(field):
    lowest = field[0]
    lowest_index = 0
    result = []
    for iteration in range(len(field)):
        for i in range(len(field)):
            if field[i] < lowest:
                lowest = field[i]
                lowest_index = i

        field.pop(lowest_index)
        result.append(lowest)
        if field != []:
            lowest = field[0]
            lowest_index = 0
        else:
            continue
        
    print(result)



field = [5,2,8,5,1,2,8,4,5,4,8,2,1]
print(field)
selectionSort(field)