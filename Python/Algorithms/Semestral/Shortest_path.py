#!/bin/python3

class Map:
    def __init__(self):
        self.graph = []
        self.default = 1e10
        self.lenght = 0
        self.route = []
        self.distance = {}
        


    def min_distance(self, source):
        output=None
        minimum = self.default
        for i in range(self.lenght):
            if source[i].get("distance") < minimum and source[i].get("visited") == False:
                minimum = source[i].get("distance")
                output = i
        return output

    def has_connection(self,a,b:str) -> bool:
        if len(self.previous[a]) <= len(self.previous[b]):
            helper = len(self.previous[b])
        else:
            helper = len(self.previous[a])
        if a not in self.previous or b not in self.previous:
                return False

        for i in range(helper):
            if self.previous[a][i] == b or self.previous[b][i] == a:
                return True
        return False


    def add_single_connection(self, start:str, end:str, dist:float):
        new_thread = dict(previous=start, destination=end, distance=dist, visited=False)
        self.graph.append(new_thread)
        self.lenght += 1
        if end not in self.distance:
            self.distance[end] = self.default
        

    def add_multiple_connections(self, conn:list):
        pass

    def find_route(self, start:str, end:str):
        self.distance[start] = 0
        graph_copy = self.graph[:]
        graph_copy.append(dict(previous=start, destination=start, distance=0, visited=True))
        starter_node = graph_copy[-1]

        for i in range(self.lenght):
            shortest = self.min_distance(graph_copy)
            shortest_dest = graph_copy[shortest].get("destination")
            if graph_copy[shortest].get("distance") < self.distance[shortest_dest]:
                self.distance[shortest_dest] = graph_copy[shortest].get("distance")
            graph_copy[shortest].update(visited= True)

        furthest_point = end
        self.route.insert(0,end)
        i=0
        while furthest_point != start:
            if graph_copy[i].get("distance") == self.distance[furthest_point] and graph_copy[i].get("destination") == furthest_point:
                self.route.insert(0, graph_copy[i].get("previous"))
                furthest_point =  graph_copy[i].get("previous")
                i=0
            i+=1
        return (self.route)            



        
      
        
        

        
        

            
            
            



        

        





m = Map()
m.add_single_connection("A", "C", 7)
m.add_single_connection("A", "B", 8)
m.add_single_connection("B", "C", 5)
m.add_single_connection("D", "C", 8)
m.add_single_connection("A", "D", 7)

print(m.find_route("A", "C"))