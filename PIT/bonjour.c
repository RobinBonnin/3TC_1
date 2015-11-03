//Programme Bonjour
#include <stdio.h>
int main () 
{
	int francophone, anglophone, aucun;
	printf("Êtes vous francophone ? \n");
	scanf("%d",&francophone);
if (francophone=1) {
		printf("Bonjour ! \n");
	}
	else {
		printf("Do you speak English ? \n");
		scanf("%d",&anglophone);
	if (anglophone==1) {
			printf("Hello ! \n");
		}
		else {
			printf("Ni xao ! \n");
		}
	}
	return 0;
}
