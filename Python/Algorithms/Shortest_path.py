# Simple implementation of Dijskstra's algorithm (DSA) to find shortest path in a graph represented by a dictionary

class Map:
    def __init__(self):
        # Graph represented by a dictionary: node - list of neighbours (with the distance of a vertex)
        self.graph = {}

    def _normalize(self, name: str) -> str:
        # Text normalization function (lowercase, no spaces)
        return name.strip().lower()

    def add_single_connection(self, start: str, end: str, dist: float):
        # Check for negative values
        if dist < 0:
            raise ValueError("Distance must be non-negative")

        # Normalization of names
        start = self._normalize(start)
        end = self._normalize(end)

        # Adding the names to the graph, if they aren't included yet
        self.graph.setdefault(start, []) 
        self.graph.setdefault(end, [])

        # Double sided connection
        self.graph[start].append((end, dist))
        self.graph[end].append((start, dist))

    def add_multiple_connections(self, conn: list):
        # Adding more connection at the same time
        for start, end, dist in conn:
            self.add_single_connection(start, end, dist)

    def find_route(self, start: str, end: str):
        # Normalization of names, checking if they exist
        start = self._normalize(start)
        end = self._normalize(end)

        if start not in self.graph or end not in self.graph:
            raise ValueError("Start or end node does not exist in the graph")

        # Inicialization of distance and previous nodes
        distances = {node: float('inf') for node in self.graph}
        previous = {}
        distances[start] = 0

        unvisited = set(self.graph.keys())

        # Dijkstra's algorithm
        while unvisited:
            # Searching for candidates - unprocessed nodes with finite distance
            candidates = []

            # For every node in list of undiscovered nodes
            for node in unvisited:
                # If we had visited it at least once 
                if distances[node] != float('inf'):
                    # Add to canditates for next processing
                    candidates.append(node)

            # If no candidates found, break cycle
            if not candidates:
                break

            # Select the one with the lowest distance
            current_node = candidates[0]
            for node in candidates:
                if distances[node] < distances[current_node]:
                    current_node = node

            if current_node is None:
                break  # Rest is unreachable

            unvisited.remove(current_node)

            for neighbor, distance in self.graph[current_node]:
                if neighbor in unvisited:
                    new_distance = distances[current_node] + distance
                    if new_distance < distances[neighbor]:
                        distances[neighbor] = new_distance
                        previous[neighbor] = current_node

        # If no path was found
        if distances[end] == float('inf'):
            return (None, [])

        # Reconstruction of path (Backtracking previous nodes)
        path = []
        node = end
        while node != start:
            path.insert(0, node)
            node = previous[node]
        path.insert(0, start)

        return (distances[end], path)

