# Ověření bezpečnosti uložení
def is_safe(row, col, queens):
    for r, c in queens:
        if c == col or abs(r - row) == abs(c - col):
            return False
    return True
# Řešení pro N dam
def solve_n_queens(n, fixed_row, fixed_col):
    # řešení: (<pozice dámy 1>, <pozice dámy 2>, ... , <pozice dámy n>)
    '''
    Podmínky:   1) Dvě dámy nesmí být ve stejném sloupci
                2) Dvě dámy nesmí být na stejné diagonále 
                3) n >= 4 (pro menší nemá smysl)
    '''

    solutions = [] # proměnná pro řešení

    # Hledání řešení s návratem
    def backtrack(row, queens):
        if row == n:
            solutions.append(list(queens))
            return

        # Pokud jsme na řádku s fixovanou dámou, musí být na pevné pozici
        if row == fixed_row:
            if is_safe(row, fixed_col, queens):
                queens.append((row, fixed_col))
                backtrack(row + 1, queens)
                queens.pop()
        else:
            for col in range(n):
                if is_safe(row, col, queens):
                    queens.append((row, col))
                    backtrack(row + 1, queens)
                    queens.pop()

    backtrack(0, [])
    return solutions

def print_board(n, queens):
    board = [['.' for i in range(n)] for o in range(n)]
    for r, c in queens:
        board[r][c] = 'Q'
    for row in board:
        print(' '.join(row))
    print()

def main():
    print("Problém N dam s pevnou dámou na dané pozici")
    n = int(input("Zadej počet dam (n): "))
    fixed_row = int(input(f"Zadej řádek dámy (0 až {n-1}): "))
    fixed_col = int(input(f"Zadej sloupec dámy (0 až {n-1}): "))

    solutions = solve_n_queens(n, fixed_row, fixed_col)

    if not solutions:
        print("Žádné řešení nebylo nalezeno.")
        return

    print(f"Nalezeno {len(solutions)} řešení. První řešení:\n")
    print_board(n, solutions[0])

    i = 1
    while i < len(solutions):
        cont = input("Zobrazit další řešení? (Enter = ano, jinak konec): ")
        if cont.strip():
            break
        print_board(n, solutions[i])
        i += 1

if __name__ == "__main__":
    main()