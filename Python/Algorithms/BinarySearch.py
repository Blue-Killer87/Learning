def binarySearch(arr:list, x:any) -> int:
    min = 0
    max = len(arr) - 1
    while min <= max:
        mid = (min+max) // 2
        if x < arr[mid]:
            max = mid - 1 
        elif x > arr[mid]:
            min = mid + 1
        else:
            return(mid)
    return(None)


l = [1,2,3,6,9,21,33,44,66,77,90,91,92,95,100,1000,100000]
print(binarySearch(l, 6))
