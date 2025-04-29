class Node:
    def __init__(self, data):
        self.data = data
        self.num_predecessors = 0
        self.successor_list = []

    def __str__(self):
        result = f"{self.data}: pred={self.num_predecessors}, list= ["
        for n in self.successor_list:
            result += str(n.data)+ ' '
        return result + ']'

class TopologySort:
    def __init__(self):
        self.node_list = []
        self.zero_list = []

    def find_or_add(self, data):
        for x in self.node_list:
            if x.data == data:
                return x
        new = Node(data)
        node_list.append(new)
        return(new)
            