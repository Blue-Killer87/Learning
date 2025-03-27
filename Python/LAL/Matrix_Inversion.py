
# Test Matrix Input (for debbuging )
#Matrix = [[1,2,3,4], [1,1,1,1], [1,2,1,2], [3,2,4,2]]
#n = 4


def Identity(n):
    Matrix = [[1 if i == j else 0 for j in range(n)] for i in range(n)]
    return(Matrix)

# Funkce na prohození řádků... Myslel jsem že to bude víc potřeba.
def swap(a,b):
    return(b,a)


def Find1(Matrix, x):
    TempMatrix = [] 
    mult = 1
    index = 0

    for i in Matrix:
        if index >= x:
            TempMatrix.append(i)
        index += 1

    # Main part of the function
    index = 0
    for row in TempMatrix:
        mult = row[x]
        if mult == 0:
            testReg(TempMatrix)
            index += 1
            continue

        if row[x]/mult == 1: 
            TargetIndex = index
            TargetMult = mult
            TargetRow = row
            break
        index += 1
    mult = 0
    index = 0

    for i in TargetRow:
        i = i/TargetMult
        row[index] = i
        index += 1
    
    return(row, TargetIndex+x, TargetMult)



def Matrix_Input():
    Matrix = []
    print("\033c")
    print("Matrix Inversion\n\nFirstly, state the dimension of the Matrix (any number)\nIt is a square Matrix, so dimension of n is going to be n x n\n\nNext, add specified row of the Matrix in format x x x (ed. 1 2 3)\nEvery row will number of inputs accprding to the dimension.\n\n\n")
    input("Press enter to continue")
    for i in range (100):
        print("_", end='')
    Dimension = 0
    Dimension = int(input('\n\n\nPlease state the dimension of your matrix: '))
    while Dimension < 2:
        print('\n\n\nDimension must be greater than 1')
        Dimension = int(input('Please state the dimension of your matrix: '))
    for i in range(Dimension):
        Matrix_part = []
        try:
            Matrix_part= input(f'\State {i+1}. row: ') 
            Matrix_part = Matrix_part.split()
        except:
            Matrix_part= input(f'\n\nWrong input, only numbers are possible \nPlease state {i+1}. row again: ')
            Matrix_part = Matrix_part.split()
        
        
        index = 0
        
        while True:
            try: 
                if Matrix_part == []:
                    raise TypeError()
                for l in Matrix_part:
                    Matrix_part[index] = int(l) 
                    index += 1
                if index != Dimension: 
                    raise TypeError()
                break

            except TypeError:
                Matrix_part= input(f'\n\nWrong input, please state {Dimension} numbers to the row \nPlease state {i+1}. row again:')
                Matrix_part = Matrix_part.split()
                index = 0
            except:
                Matrix_part= input(f'\n\nWrong input, only numbers are possible \nPlease state {i+1}. row again: ')
                Matrix_part = Matrix_part.split()
                index = 0
            
        Matrix.append(Matrix_part)
    print("\033c")
    return(Matrix, Dimension) 

def NumberNormalization(n):
    rowIndex = 0
    posIndex = 0
    for row in n: 
        for i in row: 
            if i == int(i):
                n[rowIndex][posIndex] = int(i)
            else:
                n[rowIndex][posIndex] = round(i, 3) 
            posIndex +=1
        rowIndex += 1
        posIndex = 0
    return(n)


def testReg(Matrix):
    testcase0 = []
    for l in range(n):
        testcase0.append(0) 
    for i in Matrix:
        if i == testcase0: 
            raise Exception("Matrix is singular, therefore it cannot be inverted.") 


def Invert(Matrix, n):
    Gauss_start = []
    leadingIndex = 0
    row = 0

    id_Matrix = Identity(n) 
    Gauss_start.append(Matrix)
    Gauss_start.append(id_Matrix)
    l = 0
    print("\nStated matrix:")
    for i in Gauss_start[0]:
        print(f"{i}|{Gauss_start[1][l]}")
        l += 1

        GetOne = Find1(Matrix, leadingIndex) 
        leadingRow = GetOne[0] 
        leadingRowIndex = GetOne[1] 
        Matrix[leadingRowIndex] = leadingRow 

        a,b = swap(Matrix[leadingIndex], Matrix[leadingRowIndex]) 
        Matrix[leadingIndex] = a
        Matrix[leadingRowIndex] = b

        a,b = swap(id_Matrix[leadingIndex], id_Matrix[leadingRowIndex])
        id_Matrix[leadingIndex] = a
        id_Matrix[leadingRowIndex] = b

        TargetMult = GetOne[2]

        for i in range(n):
            id_Matrix[leadingIndex][i] = id_Matrix[leadingIndex][i]/TargetMult
            
        row +=1

        mult = 1
        HowManyLeft = n-row
        localIndex = n-HowManyLeft

        for i in range(HowManyLeft):
            while Matrix[localIndex][leadingIndex] != 0:
                operator = Matrix[localIndex][leadingIndex]
                mult = operator 
                operator = operator - leadingRow[leadingIndex]*mult 
                if operator == 0: 
                    index = 0
                    for i in Matrix[localIndex]:
                        Matrix[localIndex][index] = i - leadingRow[index]*mult
                        id_Matrix[localIndex][index] = id_Matrix[localIndex][index]-id_Matrix[leadingIndex][index]*mult
                        index += 1

                operator = Matrix[localIndex][leadingIndex]
                operator = operator + leadingRow[leadingIndex]*mult
                if operator== 0:
                    index = 0
                    for i in Matrix[localIndex]:
                        Matrix[localIndex][index] = i + leadingRow[index]*mult
                        id_Matrix[localIndex][index] = id_Matrix[localIndex][index]+id_Matrix[leadingIndex][index]*mult
                        index += 1

                mult = 0 
            localIndex += 1
            mult = 1
        leadingIndex +=1

    testReg(Matrix) 
        


    # The backwards Gaussian elimination (eliminating numbers above ones on diagonal)
    x = n-1    
    while x > 0:
        index = 0
        currentRow = Matrix[x-1]
        for i in currentRow:
            operator = 1 
            mult = 1
            idIndex = 0
    
            # Case for zero
            if i == 0: 
                index += 1
                continue

            # Case for one on diagonal
            elif i == 1 and index == x-1: 
                index += 1
                continue

            # Other cases
            else:     
                while operator != 0:
                    mult = currentRow[index]
                    operator = currentRow[index] - Matrix[index][index]*mult 

                    if operator == 0: 
                        Matrix[x-1][index] = 0 
                        # Editing matrix according to the multiplier
                        for i in id_Matrix[x-1]: 
                            id_Matrix[x-1][idIndex] = i - id_Matrix[index][idIndex]*mult
                            idIndex += 1
                        index += 1

                    mult = 0            
        x -= 1

    Matrix = NumberNormalization(Matrix)
    id_Matrix = NumberNormalization(id_Matrix)
    return(Matrix, id_Matrix)


Input = Matrix_Input() # The input handler function, comment if you want to use the debug way
Matrix = Input[0] 
n = Input[1]


# Output of the results to the console
Gauss = Invert(Matrix, n)
l = 0
print("\nAfter Gaussian Elimination: ")
for i in Gauss[0]:
    print(f"{i}|{Gauss[1][l]}")
    l += 1

print("\nInverted matrix: ")
for i in Gauss[1]:
    print(f"{i}")
    l += 1
print("\n")