class Map:
    def __init__(self): # TODO: vytvori praznou Mapu
        self.graph = {}          # {node: [(neighbor, weight), ...]}
        self.route = []          # shortest path from start to end
        self.distance = {}       # shortest distance from start to each node


    def add_single_connection(self, start: str, end: str, dist: float):
        if start not in self.graph:
            self.graph[start] = []
        self.graph[start].append((end, dist))
        # Ensure end is also present in the graph
        if end not in self.graph:
            self.graph[end] = []

    def add_multiple_connections(self, conn:list):
        for i in conn:
            self.add_single_connection(i[0], i[1], i[2])
            print(f'Adding connectiong: {i[0]},{i[1]}')

    def find_route(self, start: str, end: str):
        unvisited = list(self.graph.keys())
        self.distance = {node: float('inf') for node in self.graph}
        self.distance[start] = 0
        previous = {}  # {node: predecessor}

        while unvisited:
            # Find the unvisited node with the smallest known distance
            current = min(
                (node for node in unvisited if self.distance[node] < float('inf')),
                key=lambda node: self.distance[node],
                default=None
            )
            if current is None:
                break  # All remaining unvisited nodes are inaccessible

            unvisited.remove(current)

            for neighbor, weight in self.graph[current]:
                new_dist = self.distance[current] + weight
                if new_dist < self.distance[neighbor]:
                    self.distance[neighbor] = new_dist
                    previous[neighbor] = current

        # Reconstruct the path from start to end
        self.route = []
        if end not in previous and start != end:
            return None  # No route

        node = end
        self.route.insert(0, node)
        while node != start:
            node = previous[node]
            self.route.insert(0, node)

        return self.route