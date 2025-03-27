import random
class Node:
    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        return str(self.data)


class BinaryTree:
    def __init__(self, list):
        self.root = None
        self.previous = None
        for item in list:
            self.insert(item)

    def empty(self) -> bool:
        """ Vrátí True, když strom neobsahuje žádné prvky, jinak vrátí False """
        return self.root is None

    def insert(self, data):
        if self.root == None:
            self.root = Node(data)
        else:
            self.insert_recurant(self.root, data)
            
    def insert_recurant(self, node:Node, data:int):
        if node == None:
            return       
        if node.data == data: return
        if data > node.data:
            if not node.left:
                node.left = Node(data)
            else:
                self.insert_recurant(node.left, data)
        else:
            if not node.right:
                node.right = Node(data)
            else:
                self.insert_recurant(node.right, data)


    def print2(self):
        level =0
        st= "root"
        if self.root == None:
            return
        else:
            self.print_recurant2(self.root, level, st)
            
    def print_recurant2(self, node: Node, level, st):
        if node == None:
            return
        else:

            print(level*"    " + st + ":" + str(node))
            self.print_recurant2(node.left, level+1, st="L")
            self.print_recurant2(node.right, level+1, st="R")

    def find(self, what):
        if self.empty(): return None
        current = self.root
        while current.data != what:
            if current.data > what:               
                current = current.right
            else:
                current = current.left
            if current is None: break
        return current

    def IsInTree(self, what):
        if self.empty(): return None
        current = self.root
        while current.data != what:
            if current.data > what:               
                current = current.right
            else:
                current = current.left
            if current is None: 
                return False
                break
        return True   

    def depth(self):
        if self.empty(): return None
        current = self.root
        depth = 0
        if current.right:
            while current != None:
                current = current.right
                depth +=1 
            return depth
        else:
            while current != None:
                current = current.left
                depth +=1
            return depth


    def min(self):
        if self.root is None:
            return self.root        
        current = self.root
        while current.right != None:
            current = current.right
        return current


    def max(self):
        if self.root is None:
            return self.root     
        
        current = self.root
        while current.left != None:
            current = current.left
        return current


    def remove(self, what):
        if (what.left == None) and (what.right == None):
            remove_node(what)
        elif (what.left == None) or (what.right == None):
            remove_one_child(what)
        else:
            remove_two_child(what)
        
    def remove_node(self, what):
        if what is self.root:
            self.root = None
        
        
size = random.randint(15,20)
print(size)
randomVec = random.sample(range(5,50), size)
print(randomVec)

node_1 = Node(16)
tree = BinaryTree(randomVec)
tree.print2()
print(f"Min: {tree.min()}, Max: {tree.max()}\n")

if tree.IsInTree(21):
    print(tree.find(21))
else:
    print("Error 404: 21 not found")

print(f"\nDepth: {tree.depth()}")


