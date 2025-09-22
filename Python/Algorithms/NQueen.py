# The N-Queen problem solver program using backtracking method with one set queen (user inputed)

# Checking for safety of placement
def is_safe(row, col, queens):
    for r, c in queens:
        if c == col or abs(r - row) == abs(c - col):
            return False
    return True

# Solving the N-Queen problem
def solve_n_queens(n, fixed_row, fixed_col):
    '''
    rules:      1) Two queens cannot be on the same collum or row
                2) Two queens cannot be on the same diagonal 
                3) n >= 4 (not worth it for lesser)
    '''


    solutions = [] # Variable for solution storage

    # Searching for solution using return values (backtracking)
    def backtrack(row, queens):
        if row == n:
            solutions.append(list(queens))
            return

        # If we are one the row with set queen, it's position must be absolute
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
    print("Problem of N Queens with one queen on set position")
    n = int(input("\nSet the number of Queens (n): "))
    while n <= 3:
        print('Please set number greater than 3')
        n = int(input("Set the number of Queens (n): "))
    fixed_row = int(input(f"Please define the row of set queen (1 to {n}): "))-1
    while fixed_row not in range(1, n):
        fixed_row = int(input(f"Please define the row of set queen (1 to {n}): "))-1
    fixed_col = int(input(f"Please define the collum of set queen (1 to {n}): "))-1
    while fixed_row not in range(1, n):
        fixed_col = int(input(f"Please define the collum of set queen (1 to {n}): "))-1

    solutions = solve_n_queens(n, fixed_row, fixed_col)

    if not solutions:
        print("\nNo solution found for this problem.")
        return

    print(f"\nFound {len(solutions)} solutions. First solution:\n")
    print_board(n, solutions[0])

    i = 1
    while i < len(solutions):
        cont = input("\nShow next solution? (Enter = yes, other = end): ")
        if cont.strip():
            break
        print("\033c")
        print_board(n, solutions[i])
        
        i += 1

if __name__ == "__main__":
    main()