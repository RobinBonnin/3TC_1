#include <stdio.h>
int main () {
	int variable,n;
	printf("Donner un nombre \n");
	scanf("%d",&variable);
	if (variable>20) {
		printf("C'est trop long, tu ne veux pas voir ça \n");
	}
	else {
		printf("Les carrés de 0 à %d \n", variable);
		int i;
		for (i=0;i<=variable;i++) {
			n=i*i;
			printf("n²=%d \n",n);
		}
}
		return 0;
}


