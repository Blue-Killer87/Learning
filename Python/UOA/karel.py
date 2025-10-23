# karel.py

# Konstanty pro směry
E = EAST = 0
N = NORTH = 1
W = WEST = 2
S = SOUTH = 3

# Znaková reprezentace směrů robota
ROBOT_CHARS = {
    EAST:  ">",
    NORTH: "^",
    WEST:  "<",
    SOUTH: "v",
}

_active_world = None   # globálně aktivní svět


class Cell:
    def __init__(self, wall: bool = False, markers: int = 0):
        self.wall = wall
        self.markers = markers

    def __str__(self):
        if self.wall:
            return "#"
        elif self.markers > 0:
            return str(self.markers)
        else:
            return " "


class World:
    def __init__(self, rows: int, cols: int):
        self.rows = rows
        self.cols = cols
        self.grid = [[Cell() for _ in range(cols)] for _ in range(rows)]
        self.karel = None

    def place_karel(self, row: int, col: int, dir4: int):
        self.karel = Karel(self, row, col, dir4)

    def in_bounds(self, row: int, col: int) -> bool:
        return 0 <= row < self.rows and 0 <= col < self.cols

    def __str__(self):
        result = []
        for r in range(self.rows):
            line = []
            for c in range(self.cols):
                if self.karel and self.karel.row == r and self.karel.col == c:
                    line.append(ROBOT_CHARS[self.karel.dir])
                else:
                    line.append(str(self.grid[r][c]))
            result.append("".join(line))
        return "\n".join(result)


class _Karel:
    def __init__(self, world: World, row: int, col: int, dir4: int = EAST):
        if row < 0:
            row = world.rows + row
        if col < 0:
            col = world.cols + col

        if not world.in_bounds(row, col):
            raise ValueError("Robot umístěn mimo svět!")

        self.world = world
        self.row = row
        self.col = col
        self.dir = dir4

    # --- Pohybové akce ---
    def step(self):
        dr, dc = {EAST:(0,1), NORTH:(-1,0), WEST:(0,-1), SOUTH:(1,0)}[self.dir]
        nr, nc = self.row + dr, self.col + dc
        if not self.world.in_bounds(nr, nc) or self.world.grid[nr][nc].wall:
            raise RuntimeError("Náraz do zdi!")
        self.row, self.col = nr, nc

    def turn_left(self):
        self.dir = (self.dir + 1) % 4

    def pick(self):
        cell = self.world.grid[self.row][self.col]
        if cell.markers <= 0:
            raise RuntimeError("Žádná značka k sebrání!")
        cell.markers -= 1

    def put(self):
        cell = self.world.grid[self.row][self.col]
        if cell.wall:
            raise RuntimeError("Na zdi nelze položit značku!")
        if cell.markers >= 9:
            raise RuntimeError("Překročen maximální počet značek (9)!")
        cell.markers += 1

    # --- Testovací funkce ---
    def is_east(self):
        return self.dir == EAST

    def is_marker(self):
        return self.world.grid[self.row][self.col].markers > 0

    def is_wall(self):
        dr, dc = {EAST:(0,1), NORTH:(-1,0), WEST:(0,-1), SOUTH:(1,0)}[self.dir]
        nr, nc = self.row + dr, self.col + dc
        if not self.world.in_bounds(nr, nc):
            return True
        return self.world.grid[nr][nc].wall


# --- Globální API ---

def new_world(*args):
    global _active_world
    _active_world = None

    if len(args) == 2 and all(isinstance(x, int) for x in args):
        rows, cols = args
        _active_world = World(rows, cols)

    elif all(isinstance(x, str) for x in args):
        rows = len(args)
        cols = max(len(row) for row in args)
        _active_world = World(rows, cols)
        for r, line in enumerate(args):
            for c, ch in enumerate(line):
                if ch == "#":
                    _active_world.grid[r][c] = Cell(wall=True)
                elif ch.isdigit():
                    _active_world.grid[r][c] = Cell(markers=int(ch))
                else:
                    _active_world.grid[r][c] = Cell()
    else:
        raise ValueError("Neplatné parametry pro new_world")

def show_world():
    if not _active_world:
        print("Žádný aktivní svět")
    else:
        print(_active_world)

def Karel(row: int = -1, col: int = 0, dir4: int = EAST):
    if not _active_world:
        raise RuntimeError("Nejdřív vytvoř svět pomocí new_world()!")
    _active_world.karel = _Karel(_active_world, row, col, dir4)
    return _active_world.karel
