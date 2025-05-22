#ifndef __XLIST_H__
#define __XLIST_H__

#include <stdint.h>
#include "list.h"
#include "xref.h"

#define CONTAINER_OF(PTR,TYPE,MEMBER) ((TYPE *)(((intptr_t)(PTR)) - ((intptr_t)&(((TYPE *)0)->MEMBER))))

struct x_s {
	struct list_s Hook;
	struct xref_s XRef;
	int x;
};

struct x_s *x_create (int x);
struct x_s *x_get_next (struct list_s *List, struct x_s *Prev);
struct x_s *x_get_prev (struct list_s *List, struct x_s *Next);
void x_add_head (struct x_s *Item, struct list_s *List);
void x_add_tail (struct x_s *Item, struct list_s *List);
int x_remove (struct x_s *Item);
void x_get (struct x_s *Item);
int x_put (struct x_s *Item);

#endif

