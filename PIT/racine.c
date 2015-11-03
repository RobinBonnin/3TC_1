#include <stdio.h>
#include <math.h> 
int main () {
	int nombre;
	float rnombre;
	printf("Donner un nombre \n");
	scanf("%d",&nombre);

	if (nombre<0) {
		printf("Pas possible ! \n");
	}
	else {
		rnombre=sqrt(nombre);
		printf("La racine carrée de %d est %f \n",nombre,rnombre);
	}
}
