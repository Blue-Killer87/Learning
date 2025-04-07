def binarySearchRecursion(arr:list, x:any, min:int, max:int) -> int:
    if min <= max:
        mid = (min+max)//2
        if x < arr[mid]:
            return binarySearchRecursion(arr, x, min, mid-1)
        elif x > arr[mid]:
            return binarySearchRecursion(arr, x, mid+1, max)
        else:
            return mid
    return(None)


l = [1,2,3,6,9,21,33,44,66,77,90,91,92,95,100,1000,100000]
print(binarySearchRecursion(l, 6, 0, len(l)-1))