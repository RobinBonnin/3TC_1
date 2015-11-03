#include <stdio.h>

int main() {
  char operateur;
  int nombre,mem;
  while (operateur!='E') {
    printf("Donner votre opération \n");
    scanf("%d %c",&nombre, &operateur);

    if(operateur=='S') {
      mem=nombre;
      printf(" = %d\n",mem);    
    }
    else if(operateur=='+') {
      mem=nombre+mem;
      printf(" = %d\n",mem);
    }
    else if(operateur=='-'){
      mem=nombre-mem;
      printf(" = %d\n",mem);
    }
    else if(operateur=='*') {
      mem=nombre*mem;
      printf(" = %d\n",mem);
    }
    else if (operateur=='/'){
      mem=(mem/nombre);
      printf(" = %d\n",mem);
    }
    else if(operateur=='E') {
    }
    else {
    }
  }
}
