from math import *

class karl():
    def __init__(self, dimension):
        self.position = [0,0]
        self.dimension = dimension
        self.directions = {"down": "V", "up": "^", "left": "<", "right": ">"}
        self.direction = "right"

    def render(self):
        print("\033c")
        self.screen  = [['.' for i in range(self.dimension)] for o in range(self.dimension)]
        self.screen[self.position[0]][self.position[1]] = self.directions[self.direction]
        for row in self.screen:
            print(' '.join(row))
        print()
        self.karlInput()
    
    def step(self, direction):
        self.screen[self.position[0]][self.position[1]] = '.'
        if direction == "left":
            self.position = [self.position[0], self.position[1]-1]
            self.direction = "left"
            self.render()
        
        if direction == "right":
            self.position = [self.position[0], self.position[1]+1]
            self.direction = "right"
            self.render()

        if direction == "up":
            self.position = [self.position[0]-1, self.position[1]]
            self.direction = "up"
            self.render()

        if direction == "down":
            self.position = [self.position[0]+1, self.position[1]]
            self.direction = "down"
            self.render()

    def karlInput(self):
        direction = input("Zadejte příkaz (left, right, up, down): ")
        self.step(direction)
        

new = karl(15)
new.render()