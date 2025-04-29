#!/bin/python3

class Map:
    def __init__(self):
        self.graph = []
        self.default = 1e10
        self.known = []
        self.lenght = 0
        self.distance = []
        self.previous = []

    def min_distance(self, source):
        output=None
        minimum = self.default
        
        for i in range

        return output



    def add_single_connection(self, start:str, end:str, dist:float):
        new_thread = []
        new_thread.append(start)
        new_thread.append(end)
        new_thread.append(dist)
        self.graph.append(new_thread)
        self.lenght += 1


    def add_multiple_connections(self, conn:list):
        pass

    def find_route(self, start:str, end:str):
        self.distance[start] = [0]
        self.route = []
        #(self.previous)
        #print(self.distance)

        self.known=[False for i in range(self.lenght)]
        self.distance=[self.default for i in range(self.lenght)]
        
        # Calculating shortest distances (+storing them)
        for i in range(self.lenght):
            shortest = self.min_distance(self.distance)
            #print(shortest)

            for i in range(self.lenght):
                if self.known[i] == True or self.distance[i] = 0:
                    continue
                if self.distance[i]
            
            
        # Backtracking to find best route from start to end
 

        return(self.route)
            
            
            



        

        





m = Map()
m.add_single_connection("A", "C", 10)
m.add_single_connection("A", "B", 3)
m.add_single_connection("B", "C", 5)
m.add_single_connection("D", "C", 2)
m.add_single_connection("A", "D", 2)

print(m.find_route("A", "C"))