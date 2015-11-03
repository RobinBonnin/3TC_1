#include <stdio.h>
int main () {
	int nombre1, nombre2;
	printf("Donner 2 entiers \n");
	scanf("%d",&nombre1);
	scanf("%d",&nombre2);
	if (nombre1>nombre2){
		printf("Le max est %d \n", nombre1);
	}
	else {
		if (nombre1<nombre2) {
			printf("Le max est %d \n", nombre2);
		}
		else { 
			printf("Les 2 sont égaux ! \n");
		}
	}
	return 0;
}
