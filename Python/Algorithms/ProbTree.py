import random

class Node:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None   

    def __str__(self):
        return str(self.data)
    
class BinTree:
    def __init__(self) -> None:
        self.root = None

    def find(self, data) -> tuple[Node, Node]:
        current_node = self.root
        prev_node = None

        while current_node:
            if current_node.data < data:
                prev_node = current_node
                current_node = current_node.right
            elif current_node.data > data:
                prev_node = current_node
                current_node = current_node.left
            else:
                break
        
        return current_node, prev_node
    
            
    def insert(self, data) -> bool:
        current_node, prev_node = self.find(data)
        if current_node:
            return False
        
        new_node = Node(data)
        if not prev_node:
            self.root = new_node
            return True
        if prev_node.data < data:
            prev_node.right = new_node
        else:
            prev_node.left = new_node
        return True


    def print_recursive(self, node, level=0):
        if not node:
            return
        self.print_recursive(node.left, level+1)
        print(' '* 4 * level, '->', node.data)
        self.print_recursive(node.right, level+1)

    def print(self):
        self.print_recursive(self.root)
        print()


    def remove_leaf(self, current:Node, prev:Node):
        if current==self.root:
            self.root = None
            return
        if prev.left == current:
            prev.left = None
        else:
            prev.right = None
    
    def remove_in_branch(self, current:Node, prev:Node):
        if not prev:
            self.root = current.left if current.left else current.right
            return
        if prev.left == current:
            prev.left = current.left if current.left else current.right
        else:
            prev.right = current.left if current.left else current.right

    def remove_in_tree(self, current:Node):
        tmp = current.left
        tmp_prev = current
        while tmp.right:
            tmp_prev = tmp
            tmp = tmp.right
        current.data = tmp.data
        if tmp.left:
            self.remove_in_branch(tmp, tmp_prev)
        else:
            self.remove_leaf(tmp, tmp_prev)
        
    def remove(self, data):
        current, prev = self.find(data)
        if not current:
            return False
        if current.left and current.right:
            self.remove_in_tree(current)
        elif current.left or current.right:
            self.remove_in_branch(current, prev)
        else:
            self.remove_leaf(current, prev)
        return True

class OptimalTree(BinTree):
    def __init__(self, keys, P, Q):
        super().__init__()
        self.keys = keys
        self.P = P
        self.Q = Q
        self.N = len(keys)
    
    def W(self, i, j: int) -> int:
        if i==j:
            return Q[i]
        return P[j] + Q[j]+self.W(i,j-1)

    def C(self, i,j:int) -> tuple[int, int]:
        if i == j:
            return i, 0

        min_index = 0
        min_value = float('inf')
        for k in range(i+1,j+1):
            value = self.C(i,k-1)[1] + self.C(k, j)[1]
            if min_value > value:
                min_value = value
                min_index = k
        return min_index, min_value+self.W(i,j)

    def built_tree(self, i, j):
        if i>=j:
            return
        k = self.C(i, j)[0]
        self.insert(self.keys[k-1])
        
        self.built_tree(i, k-1)
        self.built_tree(k, j)
        
        








K = ['do', 'float', 'if', 'while']
Q = [2,3,1,1,1]
P = [0, 3,3,1,1]

tree = OptimalTree(K,P,Q)
#print(tree.W(0,2))
#print(tree.C(0,4))
tree.built_tree(0,4)
tree.print()