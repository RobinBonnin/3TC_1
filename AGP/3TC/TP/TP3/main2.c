#include <stdio.h>
#include <stdlib.h>
#include <pile_type.h>

int error1(char *message){
  fprintf(stderr,"%s\n",message);
  return(-1);
}

PILE InitPile () {
  PILE pile; 
  pile=(ELEMPILE*) NULL;
  return(pile);
}
int Empiler (PILE *ppile ,int nouvelem) {
  ELEMPILE *newelem; 
  if(newelem==NULL) {
  error1("Pile vide\n");
  }
 newelem=(ELEMPILE *)malloc(sizeof(ELEMPILE*));
newelem->elem=nouvelem;
 newelem->suivant=*ppile;
 *ppile=newelem;
 return(0);
}

void afficherPile (PILE pile) {
  ELEMPILE *visitor;
  visitor=pile;
  while (visitor!=NULL) {
    fprintf(stdout,"|%d|",visitor->elem);
	    visitor=visitor->suivant;
  }
  fprintf(stdout,"|--\n");
}

int Depiler (PILE *ppile) {
  if (*ppile==NULL) {
    error("Rien à dépiler\n");
  }
  else{
    ELEMPILE *suiv=(*ppile)->suivant;
    int v=(*ppile)->elem;
  free(*ppile);
  *ppile=suiv;
  *ppile=(*ppile)->suivant;
  return(v);
  }
}
int main () {
  PILE pile;
  pile=InitPile();
  Empiler(&pile,1);
  afficherPile(pile);
}
