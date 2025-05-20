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


    def Better_Insert(self, data:list):
        if len(data) <= 1:
            return
        middle = len(data)//2
        print(f'inserting number: {data[middle]}')
        self.insert(data[middle])

        leftList = data[:middle]
        rightList = data[middle:]
        self.Better_Insert(leftList)
        self.Better_Insert(rightList)



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

n=50
numbers = []

for x in range(n):
    if x not in numbers:
        numbers.append(random.randint(1,10))
   
numbers.sort()
print(numbers)


tree = BinTree()
tree.Better_Insert(numbers)
tree.print()


# tree.remove(1)
# tree.print()