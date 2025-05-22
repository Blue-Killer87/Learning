#ifndef __LIST_H__
#define __LIST_H__

struct list_s;
struct list_s {
	struct list_s *Prev;
	struct list_s *Next;
};

void list_init (struct list_s *List);
void list_item_init (struct list_s *Item);
void list_add_head (struct list_s *Item, struct list_s *List);
void list_add_tail (struct list_s *Item, struct list_s *List);
void list_remove (struct list_s *Item);

#endif

