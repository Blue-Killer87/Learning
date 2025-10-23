from karel import *

# vytvoří prázdný 5x5 svět
new_world(5, 5)
k = Karel(0, 0, EAST)
show_world()

k.put()
k.step()
k.turn_left()
show_world()

# nebo svět z textu
new_world(
    " 2# ",
    "  # ",
    "   3"
)
k = Karel(-1, -1, NORTH)
show_world()
