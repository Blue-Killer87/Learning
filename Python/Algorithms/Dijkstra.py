x = 1e10

graph = [[x,2,1,1,4,x,x,4,x],
        [2,x,x,5,x,x,x,x],
        [1,x,x,x,2,7,2,x],
        [4,5,x,x,x,x,x,4],
        [x,x,2,x,x,8,x,3],
        [x,x,7,x,8,x,2,x],
        [4,x,2,x,x,2,x,x],
        [x,x,x,4,3,x,x,x]]

def min_distance(distance, known, n) -> int:
    shortest = x
    min_index = None
    for i in range(n):
        what = distance[i]
        if distance[i] < shortest and known[i] == False:
            shortest = distance[i]
            min_index = i

    return min_index


def Dijkstra(start:int, n:int, graph):
    distance = [graph[start][i] for i in range(n)]
    known = [False for i in range(n)]
    previous = [None for i in range(n)]

    known[start] = True
    distance[start] = 0
    
    for i in range(1,n):
        shortest = min_distance(distance, known, n)
        known[shortest] = True
        for i in range(n):
            if known[i] == True:
                continue
            if distance[shortest]+graph[shortest][i] < distance[i]:
                distance[i] = distance[shortest]+graph[shortest][i]
                previous[i] = shortest
    return previous, distance



print(Dijkstra(0, 8, graph))