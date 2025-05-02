#include <stdio.h>

int i;

int
main(void){
	i = 0;	
	while(i < 5){
		i++;
		printf("%d\n", i);
	}

	for(i=5; i<10; i++) {
		printf("...\n");
	}


}
