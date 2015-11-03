#include <stdio.h>

int main () {
  int n=0,add=0;
  printf("Donner un entier\n");
  scanf("%d",&n);
  while(n%10<n) {
   add=n%10+add;
   n=n/10;
      }
  add=add+n%10;
  printf("La somme de tous les chiffres est %d\n",add);
}

