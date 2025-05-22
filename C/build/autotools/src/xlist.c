#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"
#include "xlist.h"
#include "xref.h"

struct x_s *
x_create (int x)
{
	struct x_s *_Item;

	_Item = malloc (sizeof *_Item);
	if (!_Item)
		goto out;

	memset (_Item, 0, sizeof *_Item);
	xref_init (&_Item->XRef);
	list_item_init (&_Item->Hook);

	_Item->x = x;

  out:
	return _Item;
}

struct x_s *
x_get_next (struct list_s *List, struct x_s *Prev)
{
	struct list_s *_NextItem;
	struct x_s *_Item = NULL;

	_NextItem = (Prev ? Prev->Hook : *List).Next;
	_Item = (_NextItem == List ? NULL : CONTAINER_OF(_NextItem, struct x_s, Hook));
	if (_Item)
		x_get (_Item);
	return _Item;
}

struct x_s *
x_get_prev (struct list_s *List, struct x_s *Next)
{
	struct list_s *_PrevItem;
	struct x_s *_Item = NULL;

	_PrevItem = (Next ? Next->Hook : *List).Prev;
	_Item = (_PrevItem == List ? NULL : CONTAINER_OF(_PrevItem, struct x_s, Hook));
	if (_Item)
		x_get (_Item);
	return _Item;
}

void
x_add_head (struct x_s *Item, struct list_s *List)
{
	x_get (Item);
	list_add_head (&Item->Hook, List);
}

void
x_add_tail (struct x_s *Item, struct list_s *List)
{
	x_get (Item);
	list_add_tail (&Item->Hook, List);
}

int
x_remove (struct x_s *Item)
{
	list_remove (&Item->Hook);
	return x_put (Item);
}

static void
_x_release (struct xref_s *Ref)
{
	struct x_s *_Item = CONTAINER_OF (Ref, struct x_s, XRef);
	free (_Item);
}

void
x_get (struct x_s *Item)
{
	xref_get (&Item->XRef);
}

int
x_put (struct x_s *Item)
{
	return xref_put (&Item->XRef, _x_release);
}

