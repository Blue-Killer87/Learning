#/bin/python

# ALGORITMUS:
# Snaha byla postavit algoritmus co nejvíce tak jak byla úloha zadaná, ikdyž né vždy to bylo zcela proveditelné. 
# Program tedy postupuje následovně: 
# Načtení matice -> Kontrola symetrie -> kontrola PD (Sylvester) -> Kontrola PD (Gauss) -> G-S ortogonalizační proces

# POZNÁMKA:
# Nikdy se nemohu rozhodnout zda vše v angličtině nebo v češtině z důvodů odevzdávání ve škole. 
# Tudíž je tu namíchaná angličtina v názvech funkcí a proměnných pro přehlednost a čeština v informačních hláškách a komentářích pro účely uživatele a vás. 
# (jinak by to samozřejmě bylo ve stejném jazyce, ale čeština v názvech funkcí mě děsí)
  

# Funkce na načtení matice (Zjednodušená verze oproti minulému úkolu, splňuje účel)
def matrix_input(n):
    print("Zadejte matici G (po řádcích, n čísel oddělených mezerami):")
    matrix = []
    for i in range(n):
        row = list(map(float, input(f"Řádek {i+1}: ").split())) # Rozdělení vstupu (0 1 0) na rozdělené floaty v proměnné "row". (Jde jen o úpravu vstupu na požadovaný tvar)
        if len(row) != n:
            raise ValueError("Špatný počet prvků v řádku.") # Hláska, v případě že uživatel zadá chybný počet čísel v řádku
        matrix.append(row)
    return matrix # matrix_input vrací 2d list (list listů), s kterým dále pracujeme

# Kontrola symetrie matice
def is_symmetric(matrix):
    n = len(matrix)
    for i in range(n):
        for j in range(n):
            if matrix[i][j] != matrix[j][i]: # Kontrola, zda prohozené pořádí řádků/sloupců odpovídá původním. Pokud ne, není symetrická -> False
                return False
    return True # Break case, pokud je vše v pořádku -> True

# Výpočet determinantu matice (Pro Sylvesterovo kritérium)
# Typicky jako minule za pomoci řádkových úprav převede na h-s tvar a vynásobí diagonální prvky

def determinant(matrix):
    n = len(matrix)
    A = [row[:] for row in matrix]  # kopie matice (hluboká, né odkaz)
    det = 1 # Inicializace determinantu
    for i in range(n):
        # pivot je pomocná proměnná, ukazující na diagonálu. Nesmí být nula, pokud je nula, hledáme jiný řádek, který má pivot!=0 a prohodíme řádky (plus změna znaménka)
        pivot = A[i][i] # nastavení pivotu na diagonálu
        if pivot == 0: # kontrola "nulovosti"
            # Když je pivot nula, najdeme jiný řádek kde tomu tak není
            for j in range(i+1, n):
                if A[j][i] != 0: # Pokud pivot na tomto řádku není nula:
                    A[i], A[j] = A[j], A[i] # Prohoď řádky
                    det *= -1 # Změň znaménko (cca 2 hodiny debuggingu...)
                    pivot = A[i][i] # Nastavení pivota na diagonálu (řádky jsou přehozené)
                    break
            else:
                return 0 # Pokud nic nenajde, máme smůlu a determinant se rovná 0 
        det *= pivot # Pokud se našel nenulový pivot, pronásobí ho determinantem (začíná na 1, takže vždy bude číslo)
        
        # Eliminace ostatních řádků za pomoci pivota
        # (z řádků pod pivotem uděláme nuly pomocí odečtení násobků)
        for j in range(i+1, n): 
            factor = A[j][i] / pivot # factor je pomocná proměnná na uložení násobku pro odečítání
            for k in range(i, n):
                A[j][k] -= factor * A[i][k] # Odečteme násobek pivotu
    return det # Tady už máme komplet determinant


# Funkce na výpočet Sylvesterova kritéria
# Ověříme, zda-li je matice pozitivně definitní (má čistě kladný charakter)
# Sylvesterovo kritérium říká, že všechny levé horní submatice musí mít kladný determinat.
# Přesně podle toho tato funkce pracuje. Vezme submatici (minor) a spočte její determinant
def sylvester(matrix):
    for k in range(1, len(matrix)+1):
        minor = [row[:k] for row in matrix[:k]] # Vytvoření submatice (ořezáváme od původní matice podle iterátoru)
        if determinant(minor) <= 0: # Pokud 0 nebo záporný determinant -> není PD
            return False
    return True # Pokud vše v pořádku (kladné) -> je PD

# Výpočet obecného skalárního součinu: <u,v> = u^T*G*v (pro G-S)
def generic_scalar(u, v, G):
    return sum(u[i] * sum(G[i][j] * v[j] for j in range(len(G))) for i in range(len(G)))

# Výpočet "projekce" vektoru v na vektor u podle obecného skalárního součinu
# (<v,u>/<u,u>)*u
# Potřebné pro odečtení složky vektoru ve směru jiného (pro G-S)
def project(u, v, G):
    factor = generic_scalar(v, u, G) / generic_scalar(u, u, G)
    return [factor * x for x in u]

# Výpočet klasického vektorového rozdílu
# vrací v-w
# Potřebné po "projekci", kdy odečítáme složky z vektoru, pro výpočet ortogonální části (zbytku)
def subtract(v, w):
    return [vi - wi for vi, wi in zip(v, w)]

# Gram-Schmidtův ortogonalizační proces
# Využívá předchozích funkcí, takže je relativně prostorově úsporný 
# Každý vektor očistí od složek ve směru předchozích ortogonálních vektorů.
# Výsledek se zapisuje do seznamu ortogonálních vektorů - "orthogonal"
def gram_schmidt(vectors, G):
    orthogonal = []
    for v in vectors:
        w = v[:]
        for u in orthogonal:
            p = project(u, w, G) # Volání projekce
            w = subtract(w, p) # Volání odčítání
        orthogonal.append(w) # Uložení výsledku
    return orthogonal

# Výpočet hodnosti matice pomocí Gaussovy eliminace. Počet nenulových řádků = hodnost
# Využívám to pro oveření lineární nezávislosti, vektory = LN <=> hodnost = počet vektorů
# Pravděpodobně by bylo kratší řešení, ale toto jsem měl už rozvrhnuté z minula a nejde o primární část úkolu
def gauss_rank(matrix):
    A = [row[:] for row in matrix] # Hluboká kopie matice
    n_rows = len(A) # uložení počtu řádků
    n_cols = len(A[0]) # uložení počtu sloupců
    rank = 0 
    # Iterujeme přes sloupce, hledáme řádek s nenulovým pivotem(na diagonále) na daném místě ve sloupci
    for col in range(n_cols):
        # Pokud žádný pivot není, pokračujeme dál
        pivot_row = None
        for row in range(rank, n_rows):
            if A[row][col] != 0:
                pivot_row = row
                break
            
        # Pokud pivot najdeme:    
        if pivot_row is not None:
            A[rank], A[pivot_row] = A[pivot_row], A[rank] # prohodíme řádky
            pivot = A[rank][col]
            A[rank] = [x / pivot for x in A[rank]] # Uděláme z pivota jedničku

            # Odstraňujeme prvky pod pivotem:
            for r in range(rank+1, n_rows):
                factor = A[r][col]
                # p.s. pokud náhodou nevíte, funkce zip() vratí sjednocené tuply podle indexu. Na vstup bere dva a více tuplů. Není to moc často použitelné ale tady to o dost zjednodušuje manipalaci s řádky
                A[r] = [a - factor * b for a, b in zip(A[r], A[rank])]
            rank += 1
    return rank

# Ověření lineární nezávislosti (za pomocí hodnosti matice)
def check_LN(vectors):
    # převod na matici sloupců
    matrix = [[vec[i] for vec in vectors] for i in range(len(vectors[0]))]
    return gauss_rank(matrix) == len(vectors)

# Primární část kódu, která ovládá v jakém pořadí se spustí které operace
# Je toho celkem dost a chtěl jsem využít return pro některé chybové výstupy (expeptions byly nepřehledné), takže je to ve funkci
def main():
    # Zajištění vstupu matice
    n = int(input("Zadejte dimenzi prostoru R^n: "))
    G = matrix_input(n)

    # Ošetření symetrie
    if not is_symmetric(G):
        print("Matice není symetrická.")
        return
    # Ošetření PD
    if not sylvester(G):
        print("Matice není pozitivně definitní podle Sylvesterova kritéria.")
        return

    # Zajištění vstupu počtu vektorů
    k = int(input("Zadejte počet vektorů (1 až n): "))
    if k < 1 or k > n:
        print("Neplatný počet vektorů.")
        return

    # Zajištění vstupu jednotlivých vektorů
    vectors = []
    for i in range(k):
        v = list(map(float, input(f"Zadejte vektor {i+1} (odděleno mezerami): ").split()))
        if len(v) != n:
            print("Vektor má špatnou dimenzi.")
            return
        vectors.append(v)

    # Zajištěni lineární nezávislosti
    if not check_LN(vectors):
        print("Vektory nejsou lineárně nezávislé.")
        return

    # Volání G-S
    orthogonalgonal = gram_schmidt(vectors, G)
    # Výpis výsledků z G-S
    print("\nOrtogonalizované vektory:")
    for i, v in enumerate(orthogonalgonal):
        print(f"v_{i+1} =", ["{:.4f}".format(x) for x in v]) # Trochu jsem si pohrál s výstupem aby to vypadalo co možná nejlépe (netuším jestli je nějaká korektní forma)

main() # Spuštění celého kolosu 
