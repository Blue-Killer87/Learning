class Node:
    """jeden prvek(uzel) pro spojového seznamu"""
    def __init__(self, hodnota=None):
        self.hodnota = hodnota  # ukladana hodnota, novy uzel => hodnotu ma
        self.dalsi = None     # odkaz na dalsi uzel

class SpojovySeznam:
    """Třída reprezentující celý spojový seznam"""
    def __init__(self):
        self.hlava = None  # Hlava seznamu (první prvek)
    
    def pridej_prvek(self, hodnota):
        """Přidá nový prvek na konec seznamu"""
        novy_node = Node(hodnota)
        if self.hlava is None:  # Pokud je seznam prázdný
            self.hlava = novy_node
        else:
            aktualni = self.hlava
            while aktualni.dalsi is not None:  # Najdeme poslední prvek
                aktualni = aktualni.dalsi
            aktualni.dalsi = novy_node  # Přidáme nový prvek
    
    def vypis_seznam(self):
        """Vypíše všechny prvky seznamu"""
        aktualni = self.hlava
        while aktualni is not None:
            print(aktualni.hodnota, end=" > ")
            aktualni = aktualni.dalsi
        print("0")
    
    def delka_seznamu(self):
        """Vrátí počet prvků v seznamu"""
        delka = 0
        aktualni = self.hlava
        while aktualni is not None:
            delka += 1
            aktualni = aktualni.dalsi
        return delka

def shaker_sort_sestupne(seznam):
    """Seřadí spojový seznam sestupně pomocí Shaker Sort algoritmu"""
    if seznam.hlava is None or seznam.hlava.dalsi is None:
        return  # Seznam je prázdný nebo má jen jeden prvek
    
    zmena = True
    zacatek = seznam.hlava
    konec = None
    
    while zmena:
        zmena = False
        
        # Průchod zleva doprava - posouváme nejmenší prvky doprava
        aktualni = zacatek
        while aktualni.dalsi is not konec:
            if aktualni.hodnota < aktualni.dalsi.hodnota:  # Změněno na < pro sestupné řazení
                # Prohodíme hodnoty
                aktualni.hodnota, aktualni.dalsi.hodnota = aktualni.dalsi.hodnota, aktualni.hodnota
                zmena = True
            aktualni = aktualni.dalsi
        
        if not zmena:
            break  # Pokud nedošlo k žádné změně, seznam je seřazený
        
        konec = aktualni  # Poslední prvek je na svém místě
        
        # Průchod zprava doleva - posouváme největší prvky doleva
        zmena = False
        while aktualni is not zacatek:
            predchozi = zacatek
            while predchozi.dalsi is not aktualni:
                predchozi = predchozi.dalsi
            
            if aktualni.hodnota > predchozi.hodnota:  # Změněno na > pro sestupné řazení
                # Prohodíme hodnoty
                aktualni.hodnota, predchozi.hodnota = predchozi.hodnota, aktualni.hodnota
                zmena = True
            aktualni = predchozi
        
        zacatek = aktualni.dalsi  # První prvek je na svém místě

# Vytvoření spojového seznamu
seznam = SpojovySeznam()
seznam.pridej_prvek(5)
seznam.pridej_prvek(3)
seznam.pridej_prvek(2)
seznam.pridej_prvek(1)
seznam.pridej_prvek(6)

print("Původní seznam:")
seznam.vypis_seznam()

# Seřazení pomocí Shaker Sort (od největšího k nejmenšímu)
shaker_sort_sestupne(seznam)

print("Seřazený seznam (od největšího k nejmenšímu):")
seznam.vypis_seznam()