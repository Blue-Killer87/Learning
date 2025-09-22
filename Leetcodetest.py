class ListNode(object):
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

def addTwoNumbers(l1, l2):
        """
        :type l1: Optional[ListNode]
        :type l2: Optional[ListNode]
        :rtype: Optional[ListNode]
        """

        carry = 0
        carried = False
        result = []
        if len(l1)>len(l2):
            missing = len(l1)-len(l2)
            for i in range(missing):
                l2.insert(0,0)

        if len(l1)<len(l2):
            missing = len(l2)-len(l1)
            for i in range(missing):
                l1.insert(0,0)
        
        for i in range(len(l1)):
            current = l1[-1] + l2[-1]
            if carried == True:
                current += carry
                carry = 0
                carried = False

            if current > 9:
                carry = current/10
                current = int((carry-round(carry, 0))*10)
                carry = int(round(carry, 0))
                carried = True
            
            result.append(current)
            l1.pop(-1)
            l2.pop(-1)
            
        return result
       


    
l1 = [2,4,3]
l2 = [5,6,4]

print(addTwoNumbers(l1, l2))

l1 = ListNode()

