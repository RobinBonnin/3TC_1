#include <stdio.h>
#include <stdlib.h>
int arraysum (int tab[],int n) {
  int valeur,i;
  for(i=0;i<n;i++){
    printf("%d ",tab[i]);
    valeur=valeur+tab[i];
   }
  return(valeur);
}
int main () {
  int k,i;
  printf("Donnez le nombre d'éléments du tableau \n");
  scanf("%d",&k);
  int tab[k+20];
  for(i=0;i<k;i++){
    scanf("%d",&tab[i]);
    }  
    printf("\n%d",arraysum(tab[k],k));
}

