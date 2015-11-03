//Fonction pair
int pair (int x) {
  if ((x%2)==0){
    return(1);
  }
  else {
    return (0);
  }
}

//Programme grille
#include <stdio.h>
extern void afficheEtoile(int);
int main(int argc, char ** argv; afficheEtoile) {
  int x,y,i,j;
  printf("Entrer les valeurs entières x et y puis taper entrée \n");
  scanf("%d %d", &x,&y);
  if (x>y){
    printf("Vous avez tapé %d et %d \n", x,y);
    for (j=1;j<=y;j++) {
      for (i=0;i<x;i++) {
        if (j%2==0) {
          printf("* ");
        }
        else { 
          printf(" *");
        }


      }
      printf("\n");
    }
  }
  else { 
    printf("Vous avez tapé %d et %d \n",y,x);
    for (j=1;j<=x;j++) {
      for (i=0;i<y;i++) {
        if (j%2==0) {
          printf(" *");
        }
        else {
          printf("* ");
        }
      }
      printf("\n");

    }
  }
}
