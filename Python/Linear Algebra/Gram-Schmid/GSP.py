# Gram-Schmid process

def Input():
    # Get a base of vectors to generate vector field
    # In form of [x1, x2,...xn]
    print("\033c")
    size = int(input('Specify the size of vector field: \n (Can be any full, real number)'))
    print("\033c")
    field = []
    for i in range(size):
        vector = []
        element = input(f'Specify {i+1}. vector ({size} elements sepparate by space): ')
        vector = element.split()
        index = 0
        for i in vector:
            try:
                vector[index] = int(i)
                print(f'{vector[index]}')
                index += 1
                
            except:
                raise Exception('Wrong input')

        
        field.append(vector)
    print("\033c")

    return(field)
def GSA():
    field = Input()
    print(field)


GSA()