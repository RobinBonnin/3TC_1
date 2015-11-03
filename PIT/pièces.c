#include <stdio.h>
int main () {
	int poids, centimes, euros;
	printf("Quel est le poids de la lettre ? \n");
	scanf("%d",&poids);
	if (poids<0) { 
		printf("Fou toi de moi ! \n");
	}
	else {
		if (0<poids<20) {
			centimes=50;
		}
		else {
			if (poids<50) {
				euros=1, centimes=00;
			}
			else {
				if (poids<80) {
					euros=1, centimes=20;
				}
				else {
					euros=1, centimes=50;
				} 
			}
		}
		printf("L'affranchissement coûte %d euros et %d centimes \n",euros,centimes);
		return 0;
	}
}
