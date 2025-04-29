#!/bin/python3

class Map:
    def __init__(self):
        self.graph = []
        self.default = 1e10
        self.known = []
        self.lenght = 0
        self.distance = {}

    def min_distance(self, source):
        minimum = self.default
        index = -1
        for key, value in source.items():
            index +=1
            if value < minimum and self.known[index] == False:
                minimum = value
                output = key
                
        return output, index



    def add_single_connection(self, start:str, end:str, dist:float):
        new_thread = []
        new_thread.append(start)
        new_thread.append(end)
        new_thread.append(dist)
        self.graph.append(new_thread)
        self.lenght += 1
        self.distance[end] = dist

    def add_multiple_connections(self, conn:list):
        pass

    def find_route(self, start:str, end:str):
        print(self.graph)
        self.known = [False for i in self.graph]
        
        self.distance[start] = 0
        print(self.distance)

        shortest, shortest_index = self.min_distance(self.distance)
        print(shortest, shortest_index)

        self.known[shortest_index] = True
        print(self.known)
        for i in range(1, self.lenght):
            self.min_distance(self.distance)
            
            
            



        

        





m = Map()
m.add_single_connection("A", "C", 10)
m.add_single_connection("A", "B", 3)
m.add_single_connection("B", "C", 5)
print(m.find_route("A", "C"))