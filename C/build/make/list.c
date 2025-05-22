#include <string.h>
#include "list.h"

void
list_init (struct list_s *List)
{
	List->Next = List->Prev = List;
}

void
list_item_init (struct list_s *Item)
{
	memset (Item, 0, sizeof *Item);
}

static __attribute__((always_inline)) inline void
_list_add (struct list_s *Item, struct list_s *Prev, struct list_s *Next)
{
	Item->Prev = Prev;
	Item->Next = Next;
	Next->Prev = Item;
	Prev->Next = Item;
}

void
list_add_head (struct list_s *Item, struct list_s *List)
{
	_list_add (Item, List, List->Next);
}

void
list_add_tail (struct list_s *Item, struct list_s *List)
{
	_list_add (Item, List->Prev, List);
}

void
list_remove (struct list_s *Item)
{
	if (Item->Prev != NULL && Item->Next != NULL) {
		Item->Prev->Next = Item->Next;
		Item->Next->Prev = Item->Prev;
		Item->Prev =
		Item->Next = NULL;
	}
}

