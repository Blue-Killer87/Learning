#expression = input('Zadejte výraz: ')
expression = 'A+B*(C+D)-E*(C-D)'

expression = expression.replace(' ', '')

def RPN(expr:str):
    operators = {'+':1, '-':1, '*':2, '/':2, '(':0, ')':0}
    stack = []
    output = []

    for item in expr:
        if item in operators:
            if stack == []:
                pass
            while stack != []:
                if operators[item] >= operators[stack[-1]]:
                    stack.insert(-1, item)
                    break
                else:
                    output.insert(-1, stack[-1])
                    stack.pop(-1)

        if item == '(':
            stack.insert(-1, item)
        if item == ')':
            while stack != []:
                stackTop = stack[-1]
                if stackTop != '(':
                    output.insert(-1, stackTop)
                    stack.pop(-1)
                else:
                    stack.pop(-1)
                    break

        else:
            output.insert(-1, item)

    for i in stack:
        output.insert(-1, i)
    
    for i in range(len(output)-4):
        if output[i] == '(' or output[i] == ')':
            output.pop(i)
    output = ''.join(output)
    print(output)

RPN(expression)