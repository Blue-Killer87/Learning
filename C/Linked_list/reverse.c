#include <stdio.h>
#include "list.h"
#include "xlist.h"

int
main (void){
 struct list_s _List;
 struct x_s *_Item;
 struct x_s *_Item2;
 int x;
	
 
 /* Inicialize list */
 list_init (&_List);

 /* Read number from standard input  */
 while (scanf ("%i, &x") == 1) {
	/* Create new item for the number */
	 _Item = x_create(x);
	
	 if (!_Item) 
		 goto err;

	 x_add_tail (_Item, _List);
	 x_put (_Item);
 }	
 /* Print the list in reverse order */
 for (_Item = x_get_prev (&_List, NULL); _Item; _Item2 = x_get_prev (&_List, _Item), x_put (_Item), _Item = _Item2)
	 printf ("%i\n", _Item->x);

out:
 /*Destroy the list*/
 while ((_Item = x_get_next (&_List, NULL))) {
	x_remove(_Item);
	x_put (_Item);
 }
 return _Ret;

err:
 _Ret = -1;
 fprintf(stderr, "***ERROR!\n");
 goto out;


}
