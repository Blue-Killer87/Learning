string = "abcabcbb"

def FindAllSingles(string):
    stringList = list(string)
    longest = " "
    known = []
    maxLen = 0
    for i in stringList:
        longest += i
        if longest not in known:
            known.append(longest)
        if longest.count(i) != 1:
            return known[-2]
        
def findlongest(string):
    if string == "" or string == " ":
            return 0
    listLen = []
    for i in range(len(string)):
        Current = FindAllSingles(string)
        if Current == None:
            continue
        
        Current = Current.replace(" ", "")
        listLen.append(len(Current))
        string = string.replace(Current, "")
    maxLen = max(listLen)
    return maxLen
    


print(findlongest(string))