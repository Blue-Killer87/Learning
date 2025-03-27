
# Výpočet determinantu matice
def determinant(matrix):
    if len(matrix) == 1: # Pro matici 1x1 nebudeme nic počítat (kdyby náhodou)
        return matrix[0][0]
    if len(matrix) == 2: # Pro matice 2x2 stačí klasicky vynásobit přes diagonály (šetříme čas)
        return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0]

    # Laplaceův rozvoj
    # Nejprve si vytvoříme zmenšenou matici podle aktuálního prvku -> ošetříme znaménko podle prvku -> zavoláme znovu funkci na výpočet determinantu (pro zmenšenou matici) -> Opakujeme dokud nemáme číselný determiant
    det = 0 # Hard-reset proměnné protože jeden nikdy neví
    for col in range(len(matrix)):
        sub_matrix = [row[:col] + row[col+1:] for row in matrix[1:]] # Vytvoříme si "pod-matici" podle rozvoje (Ty indexy nejsou asi nejlepší, nevím jak to vylepšit)
        sign = (-1) ** col # Ošetření znaménka
        det += sign * matrix[0][col] * determinant(sub_matrix) # Samotný výpočet determinantu (podle vzorce Laplaceovo rozvoje)
    return det



def Cramerius(Matrix, Vector, Dimension):
    # Výpočet determinantu, znovu
    Determinant = determinant(Matrix)
    
    # Ošetření regularity 
    if Determinant == 0:
        raise Exception("Matice je singulární, takže nemůže být invertována.")
    
    print(f'\n\nDeterminant matice: {Determinant}')
    
    Cramerius_Determinants = [] # Vytvoříme si proměnnou pro uložení výsledků Cramera
    
    # Uložení matice do dočasné matice (nepřepisujeme si hodnoty v původní matici)
    for col in range(Dimension):
        tempMatrix = [row[:] for row in Matrix]
        
        # Nahrazení vektorem
        for row in range(Dimension):
            tempMatrix[row][col] = Vector[row]
        
        # Výpočet determinantu upravené matice
        Cramer_Det = determinant(tempMatrix)
        Cramerius_Determinants.append(Cramer_Det / Determinant) # Výpočet členu soustavy a uložení do seznamu
    
    # Výpis řešení soustavy 
    print(f'\n\nŘešení soustavy: ')
    for i in Cramerius_Determinants:
        print(i, end='; ')

# Výpočet adjungované matice
def adjugate(matrix):
    dim = len(matrix) # potřebujeme dimenzi pro důvod o řádek níže
    adj = [[0] * dim for _ in range(dim)] # inicializuje prázdnou, nulovou matici o dimenzi dim. Proč? Bez toho to občas nemohlo najít tu proměnnou... Python, netuším.

    # Samotná funkce pro výpočet adj. matice. Značení i,j jsem přebral ze skript podle definice
    for i in range(dim):
        for j in range(dim):
            # Následující řádek vytvoří "podmatici" odstraňením i-tého řádku a j-tého sloupce z původní matice
            # Jelikož mi to trvalo dlouho než jsem to vymyslel tak menší vysvětlivky k jednotlivým aspektům:
            # matrix[:i] + matrix[i+1:] - vezme všechny řádky kromě i-tého (odstraní i-tý řádek)
            # row[:j] + row[j+1:] - vezme všechny prvky kromě j-tého z každého řádku (odstraní j-tý sloupec)
            # a celé je to zabalené ve for loopu, co projde celou matici
            sub_matrix = [row[:j] + row[j+1:] for row in (matrix[:i] + matrix[i+1:])]
            sign = (-1) ** (i + j) # řešení znaménka tak jak je to ve skriptech
            adj[j][i] = sign * determinant(sub_matrix)  # vypočte determinant "podmatice", upraví znaménko a transponuje pořadí j a i (taky podle definice)
    return adj

# Výpočet inverzní matice pomocí matice Adjungované
def inverse(matrix):
    det = determinant(matrix) # Spočteme determinant (kdyby ještě nebyl, jinak je to asi zbytečné, záleží jak se funkce volají)
    if det == 0:
        raise ValueError("Matice je singulární, nemá inverzi.") # Ošetření regularity, vyhodí podmínku
    
    adj = adjugate(matrix) # Spočteme adjungovanou matici, stejné jako u determinantu

    # Následuje výpočet inverzního prvku (adj[i][j]/det). Původně jsem to měl v další proměnné ale přišlo mi hezčí to předávat přímo jako výstup funkce...
    # Jedná se o dvě iterace, jedna probíhá podle i a druhá podle j (řádky a sloupce, dle definice). Pro každý prvek se tak provede adj[i][j]/det
    return [[adj[i][j] / det for j in range(len(matrix))] for i in range(len(matrix))] 


# Funkce pro unifikovaný výpis matice
# Je to jednoduchá funkce co vypíše název matice a její obsah, šetří to místo v kódu a dělá ho přehlednější (trochu)
# Je potřeba mu parsnout matici pro výpis a její popisek (name)
def print_matrix(Matrix, name):
    print(f"\n\n{name}:")
    for row in Matrix:
        print(row)


# Vstup matice
# Tuto funkci jsem zkopíroval ze svého kódu z inverze matice, jen jsem trošku upravil texty a přidal vektor, funguje jako minule
def Matrix_Input():
    Matrix = []
    print("\033c") # Toto vyčistí konzoli, je to jen pro efekt a přehlednost, funguje i v OnlineGDB
    print("Cramerovo pravidlo a inverzní matice\n\nTento program vypočte zadanou soustavu pomocí Cramerovo pravidla, poté vypočte ajdungovanou matici podle které nakonec vypočte matici inverzní.\n\nPrvně zadejte dimenzi matice (libovolné celé číslo)\njde o čtvercovou matici, takže matice dimenze n bude mít rozměry n x n\n\nPoté zadejte specifikovaný řádek matice ve formátu x x x (např. 1 2 3)\nKaždý řádek bude obsahovat počet čísel podle zadané dimenze.\n\nNakonec zadejte vektor o rozměrech dimenze.\n\n\n")
    input("Stiskněte enter pro pokračování ")
    for i in range (100):
        print("_", end='')
    Dimension = 0
    Dimension = int(input('\n\n\nProsím zadejte dimenzi čtvercové matice: '))
    while Dimension < 2:
        print('\n\n\nDimenze musí být větší než 1')
        Dimension = int(input('Prosím zadejte dimenzi čtvercové matice: '))
    for i in range(Dimension):
        Matrix_part = []
        try:
            Matrix_part= input(f'\nZadejte {i+1}. řádek: ') 
            Matrix_part = Matrix_part.split()
        except:
            Matrix_part= input(f'\n\nChybný vstup, možná jsou pouze čísla \nprosím zadejte znovu {i+1}. řádek: ')
            Matrix_part = Matrix_part.split()
        index = 0 
        while True:
            #Rozcestník pro obsluhy chyb zadávání + převadeč vstupu na integer hodnoty pro další zpracování
            try: 
                if Matrix_part == []:
                    raise TypeError()
                for l in Matrix_part:
                    Matrix_part[index] = int(l) # Převede str hodnotu ze vstupu na int
                    index += 1
                if index != Dimension: # Pokud je zadáno více nebo méně čísel než má být podle dimenze -> vyvolej TypError (má vlastní obsluhu níže)
                    raise TypeError()
                break
            # Obsluha pro špatný počet prvků
            except TypeError:
                Matrix_part= input(f'\n\nChybný vstup, vložte {Dimension} čísla do řádku \nprosím zadejte znovu {i+1}. řádek: ')
                Matrix_part = Matrix_part.split()
                index = 0
            # Obsluha pro špatný znak v řádku
            except:
                Matrix_part= input(f'\n\nChybný vstup, možná jsou pouze čísla \nprosím zadejte znovu {i+1}. řádek: ')
                Matrix_part = Matrix_part.split()
                index = 0
            # Matrix_part je jen proměnná obsahující řádek matice. Je to pro to, aby výsledná matice odpovídala formátu, co čeká funkce Invert.
        Matrix.append(Matrix_part)
    print("\033c")
    Vector = input(f'Zadejte vektor pravé strany ({Dimension} prvků): ')
    Vector = Vector.split()
    index = 0
    for i in Vector:
        Vector[index] = int(i)
        index += 1
    #print("\033c")
    return(Matrix, Vector, Dimension) # Vrací hodnoty, které umí funkce Invert rovnou převzít.


# Zadání hodnot a přiřazení do jednotlivých proměnných
Input = Matrix_Input()
Matrix = [row[:] for row in Input[0]]
Vector = Input[1]
Dimension = Input[2]

# Výpis zadaných hodnot
print(f'Zadaná matice:')
for row in Matrix:
    print(row)
print(f'\nZadaný vektor: ')
for i in Vector:
    print(f'[{i}]')

print('_' * 100) # čára (drsný grafický prvek, čistě pro můj dobrý pocit)
#Matrix = [[5,0,5,6], [5,1,2,9], [0,0,0,6], [3,9,8,5]]
Cramerius(Matrix, Vector, Dimension) # Volání Cramerovo řešitele

# Volání ostaních funkcí pokud determinant není nula
det = determinant(Matrix) 
if det != 0:
    # Adjungovanou nevypisuju, ale kdyžtak stačí odendat ty komentáře
    '''adj = adjugate(Matrix)
    print_matrix(adj, "Adjungovaná matice")'''
    
    inv = inverse(Matrix)
    print_matrix(inv, "Inverzní matice")