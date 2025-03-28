class DivideNConquer:
    def __init__(self):
        index = 10
        self.itemlist = []
        for i in range(index):
            self.itemlist.append(i)

    def find(self, value):
        split = self.itemlist[len(self.itemlist)//2]
        if split < value:
            print(split)
            self.itemlist[:split] = ""
            self.find(value)

        elif split > value:
            print(split)
            self.itemlist[split:] = ""
            self.find(value)
        else:
            print(split)


d = DivideNConquer()
d.find(3)