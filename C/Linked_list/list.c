#include <string.h>
#include "list.h"

struct list_s;
struct list_s{
	struct list_s *Prev;
	struct list_s *Next;
};

void 
list_init (struct list_s *List){
	List->Next = List->Prev = List; 
}

void 
list_item_init (struct list_s *Item){
	memset (Item, 0, sizeof *Item);
}

static inline void
_list_add (struct list_s *Item, struct list_s *Prev, struct list_s *Next){
	Item->Prev = Prev;
	Item->Next = Next;
	Prev->Next = Item;
	Next->Prev = Item;
}

void 
list_add_head (struct list_s *Item, struct list_s *List){
	_list_add (Item, List, List->Next);
}

void 
init_add_tail (struct list_s *Item, struct list_s *List){
	_list_add (Item, List->Prev, List);
}

void 
list_remove (struct list_s *Item){
	if (!Item->Prev && !Item->Next){
		Item->Prev->Next = Item->Next;
		Item->Next->Prev = Item->Prev;
		Item->Prev = 			//Not an error, it works, dw it's syntax magic
		Item->Next = NULL;
	}
}


