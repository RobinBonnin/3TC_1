#include <stdio.h>
#include <math.h>
#include <stdlib.h>

int main () {
  int i=0,tab[10];
  double m=0;
  while (i<10)
  {
    tab[i]=(rand()%100);
    i++;
  }
  i=0;
  while(i<10){
    m=(tab[i]+m);
    i++;
  }
  m=m/i;
  printf("La moyenne du tableau est %f \n",m);
  i=0;

  while(i<10) {
    printf("%d||",tab[i]);
    i++;
  }
  printf("\n");
}
