
# Pokud se vám nechce pro zkoušení pořád používat interaktivní vstup (což chápu), tak stačí odkomentovat tyto dva řádky a zakomentovat Matrix_Input.
#Matrix = [[1,2,3,4], [1,1,1,1], [1,2,1,2], [3,2,4,2]]
#n = 4

# Funkce Identity využívá na vstupu jeden parametr "n" a vrací matici identity o dimenzi n
# Dal jsem to do funkce, kdyby náhodou bylo potřeba to někde vytvořit, klidně se to dá dát rovnou do hlavního kódu 
def Identity(n):
    Matrix = [[1 if i == j else 0 for j in range(n)] for i in range(n)]
    return(Matrix)

# Funkce na prohození řádků... Myslel jsem že to bude víc potřeba.
def swap(a,b):
    return(b,a)


# Funkce, která vytvoří řádek s 1 na požadované pozici x
# Vrátí nám upravený řádek a index řádku, o který se jedná a čím byl vydělen
def Find1(Matrix, x):
    TempMatrix = [] # Dočasná matice (viz níže)
    mult = 1
    index = 0

    # Vytvoření dočasné matice pro práci v této funkci. Jde nám o to, že je potřeba načíst jen neupravené řádky a nechceme nikterak mazat hlavní matici
    for i in Matrix:
        if index >= x:
            TempMatrix.append(i)
        index += 1

    # Hlavní část funkce
    # Program vezme řádku z matice, nastaví "násobič" (mult) na prvek na hledané pozici daného řádku. 
    # Dále vydělíme prvek násobičem (sebou) a pokud se nám vytvoří 1 na x-té pozici tak uložíme násobič a další hodnoty a vydělíme zbytek řádku.
    index = 0
    for row in TempMatrix:
        mult = row[x]
        if mult == 0: # Pokud se jedná o nulu tak se posune dál (jinak by dělil nulou)
            testReg(TempMatrix)
            index += 1
            continue

        if row[x]/mult == 1: # Jestli se vytvořila jednička na x-té pozici tak uloží data o operaci (čím dělil, co dělil a kde)
            TargetIndex = index
            TargetMult = mult
            TargetRow = row
            break
        index += 1
    mult = 0
    index = 0
    # Vydělíme celou řádku daným násobičem
    for i in TargetRow:
        i = i/TargetMult
        row[index] = i
        index += 1
    # Vrátime hodnoty upravené řádky, o kterou řádku v matici se jedná a čím byla vydělena
    return(row, TargetIndex+x, TargetMult)


# Funkce obsluhy vstupu. Zavoláním této funkce se spustí dialog pro získání vstupní matice.
# Funguje celkem jednoduše, získává data pro matici prvek po prvku, řádek po řádku podle zadané dimenze.
def Matrix_Input():
    Matrix = []
    print("\033c") # Toto vyčistí konzoli, je to jen pro efekt a přehlednost, funguje i v OnlineGDB
    print("Inverze matice\n\nPrvně zadejte dimenzi matice (libovolné celé číslo)\njde o čtvercovou matici, takže matice dimenze n bude mít rozměry n x n\n\nPoté zadejte specifikovaný řádek matice ve formátu x x x (např. 1 2 3)\nKaždý řádek bude obsahovat počet čísel podle zadané dimenze.\n\n\n")
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
    return(Matrix, Dimension) # Vrací hodnoty, které umí funkce Invert rovnou převzít.


# Tato funkce předělává float na integer. Primárně jsem nechtěl používat dělení bez zbytku, aby se nic neztratilo, 
# takže tato funkce poté převede hodnoty do lidské formy (může být ztrátové)
def NumberNormalization(n):
    rowIndex = 0
    posIndex = 0
    for row in n: # Pro všechny řádky v matici...
        for i in row: # Pro všechny prvky v řádku...
            if i == int(i):
                n[rowIndex][posIndex] = int(i) # Převedení čísel na integer, pokud bude beztrátová konverze (předejdeme výstupům jako -0.0, 1.0, etc.)
            else:
                n[rowIndex][posIndex] = round(i, 3) # Zaokrouhlení desetiných čísel na 3 cifry, pouze pro přehlednost, funkce se používá až na finální výstup
            posIndex +=1
        rowIndex += 1
        posIndex = 0
    return(n)


# Funkce testující regularitu matice. 
# Vytvoří si řádek o dimenzi n se samými nulami a porovnává ho s řádkami v matici. 
# Pokud se některý řádek rovná nulovému, znamená to, že v matici není regulární (nemá vyplňené všechny řádky) a nejde invertovat.
def testReg(Matrix):
    testcase0 = []
    for l in range(n):
        testcase0.append(0) # Vytvoří testovací nulový řádek
    for i in Matrix:
        if i == testcase0: # Porovnává řádek z matice s nulovým řádkem
            raise Exception("Matice je singulární, takže nemůže být invertována.") # Vyhodí výjimku 


# Úplná Gaussova Eliminace
# Toto je primární funkce, která zadanou matici o dimenzi n převede na matici identity a z matice identity, která byla původně na pravé straně
# udělá invertovanou matici, kterou nakonec vypíše.
# Poznámka: šlo by to opravdu udělat jednodušeji. Chtěl jsem se držet primitivních operací, takže složitost je velká, ale logika by snad měla být snadná (doufám že to bude dávat smysl i vám). 

def Invert(Matrix, n):
    Gauss_start = []
    leadingIndex = 0
    row = 0

    id_Matrix = Identity(n) # Vytvoříme matici identity o dimenzi n

    # Výpis zadané matice rozšířené o matici identity (Volitelné, jen mi to přislo hezké) 
    Gauss_start.append(Matrix)
    Gauss_start.append(id_Matrix)
    l = 0
    print("\nZadaná matice:")
    for i in Gauss_start[0]:
        print(f"{i}|{Gauss_start[1][l]}")
        l += 1

    # Primární eliminace (Směrem shora dolů)
    # Více méně tady algoritmus vypadá +- takto:
    # Najdi řádek s jedničkou na prvním řádku -> Přesuň tento řádek na másto 1. řádku -> Vezmi 1. řádek, vynásob ho a odečti od ostatních tak, aby pod ním vznikly nuly -> posuň se o pozici doprava -> opakuj dokud nejsme na posledním řádku
    while leadingIndex < n:
        GetOne = Find1(Matrix, leadingIndex) # Zavolej o řádek s 1 na začátku
        leadingRow = GetOne[0] # Nastav si nalezený řádek
        leadingRowIndex = GetOne[1] # Nastav si o který řádek jde
        Matrix[leadingRowIndex] = leadingRow # Vlož řádek do původní matice

        # Prohoď "jedničkový" řádek na 1 pozici
        a,b = swap(Matrix[leadingIndex], Matrix[leadingRowIndex]) 
        Matrix[leadingIndex] = a
        Matrix[leadingRowIndex] = b
        #Prohoď i stranu s identitou
        a,b = swap(id_Matrix[leadingIndex], id_Matrix[leadingRowIndex])
        id_Matrix[leadingIndex] = a
        id_Matrix[leadingRowIndex] = b

        TargetMult = GetOne[2]

        # Úprava matice identity podle úpravy provedené v novém prvním řádku matice
        for i in range(n):
            id_Matrix[leadingIndex][i] = id_Matrix[leadingIndex][i]/TargetMult
            
        row +=1

        mult = 1
        #Pozn: HowManyLeft je proměnná, kterou jsem původně používal úplně jinak. Tady je jen jako využitý pozůstatek.
        HowManyLeft = n-row
        localIndex = n-HowManyLeft

        # Toto je primární část, která se stará o vynulování řádků pod jedničkou. V podstatě funguje následovně:
        # Dokud na požadované pozici řádku není 0 -> Vezmi číslo na pozici daného řádku a vynásob s ním 1 z řádku nahoře -> odečti tento "operátor" od čísla na řádku
        # -> přičti index řádku -> opakuj
        # Šlo by to zjednodušit, ovšem než mi došlo, že je to zbytečně složité tak už to bylo napsané a není dost času to předělat.
        for i in range(HowManyLeft):
            while Matrix[localIndex][leadingIndex] != 0:
                operator = Matrix[localIndex][leadingIndex]
                mult = operator # Nastav násobek jako prvek v daném řádku
                operator = operator - leadingRow[leadingIndex]*mult # Odečti čísla (vyjde 0)
                if operator == 0: # Ověř že vyšla nula (jeden nikdy neví, matematika je zrádná a zaokrouhlování o to víc)
                    index = 0
                    # Vynásob i ostatní členy tohoto řádku a odečti, stejně jako s prvním členem
                    for i in Matrix[localIndex]:
                        Matrix[localIndex][index] = i - leadingRow[index]*mult
                        id_Matrix[localIndex][index] = id_Matrix[localIndex][index]-id_Matrix[leadingIndex][index]*mult
                        index += 1

                # To samé co nahoře ale v případě že máme desetiná nebo záporná čísla (místo odčítání sčítáme)       
                operator = Matrix[localIndex][leadingIndex]
                operator = operator + leadingRow[leadingIndex]*mult
                if operator== 0:
                    index = 0
                    for i in Matrix[localIndex]:
                        Matrix[localIndex][index] = i + leadingRow[index]*mult
                        id_Matrix[localIndex][index] = id_Matrix[localIndex][index]+id_Matrix[leadingIndex][index]*mult
                        index += 1

                mult = 0 # Tady tento tvrdý reset mi opravil pár chyb, které se záhadně děli u vysokých čísel. (Asi přetékání integeru?)
            localIndex += 1
            mult = 1
        leadingIndex +=1

    testReg(Matrix) # Zkusí jestli se v matici nenachází nulový řádek po úpravách => jestli nejde o singulární matici
        


    # Zpětná eliminace (Směrem zdola nahoru)

     # Tento algoritmus funguje trochu jinak než u standardního směru eliminace.
     # Program vezme řádku z předposlední pozice a začne procházet její prvky. 
        # Celý postup se pak dělí na 3 případy: 
            # 1. Jedná se o nulu - V tomto případě není co upravovat, přičte index (posune se dál) a pokračuje
            # 2. Jedná se o jedničku a zároveň jsme na pozici, ve které jedničku chceme - Pak se jedná o jedničku na diagonále a program se jen posune dál
            # 3. Ostatní případy - nastavíme "násobič" (mult) na daný prvek a zkusíme od tohoto prvku odečíst násobek jedničky (neboli sebe sama). Zkontrolujeme,
            # že se jedná o nulu, nulu dosadíme do matice a odečteme matici identity podle daného násobiče.
        # Proces se opakuje dokud není vynulován i 1. řádek.
    x = n-1    
    while x > 0:
        index = 0
        currentRow = Matrix[x-1]
        for i in currentRow:
            operator = 1 # Operátor pro uložení výsledku odčítání
            mult = 1
            idIndex = 0
    
            # Případ pro nulu
            if i == 0: 
                index += 1
                continue

            # Případ pro 1 na diagonále
            elif i == 1 and index == x-1: 
                index += 1
                continue

            # Ostatní případy
            else:     
                while operator != 0:
                    mult = currentRow[index]
                    operator = currentRow[index] - Matrix[index][index]*mult # Zkusí čísla odečíst

                    if operator == 0: # zkontroluj že se nám vytvořila nula - Případ odčítání
                        Matrix[x-1][index] = 0 # Nastavení nuly
                        # Úprava matice identity podle násobiče
                        for i in id_Matrix[x-1]: 
                            id_Matrix[x-1][idIndex] = i - id_Matrix[index][idIndex]*mult
                            idIndex += 1
                        index += 1

                    mult = 0            
        x -= 1

    # Normalizujeme čísla v maticích
    Matrix = NumberNormalization(Matrix)
    id_Matrix = NumberNormalization(id_Matrix)
    # Vrátíme hodnoty matice a matice identity (Upravené - Matice je identita, Matice identity je invertovaná matice)
    return(Matrix, id_Matrix)


Input = Matrix_Input() # Získání vstupu, zakomentujte pokud chcete použít vstup z kódu
Matrix = Input[0] 
n = Input[1]


# Výpis hodnot do konzole (Grafická záležitost, neovlivňuje hodnoty)
Gauss = Invert(Matrix, n)
l = 0
print("\nPo Gaussovo eliminaci: ")
for i in Gauss[0]:
    print(f"{i}|{Gauss[1][l]}")
    l += 1

print("\nInvertovaná matice: ")
for i in Gauss[1]:
    print(f"{i}")
    l += 1
print("\n")
