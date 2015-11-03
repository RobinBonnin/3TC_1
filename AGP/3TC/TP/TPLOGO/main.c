#include "fonctions_logo.h"
#include <stdlib.h>








int main()
{
	
 
	
	NODE *f100 = init_elem("FORWARD",100,NULL);
	NODE *r4 = init_elem("REPEAT",4,NULL);
	NODE *l90 = init_elem("LEFT",90,NULL);
	NODE *f1002 = init_elem("FORWARD",100,NULL);
	NODE *r5 = init_elem("REPEAT",5,NULL);
	NODE *f50 = init_elem("FORWARD",50,NULL);
	NODE *f11 = init_elem("FORWARD",11,NULL);
	NODE *f12 = init_elem("FORWARD",12,NULL);
	

	
	insert_fin(f100,l90);
	insert_fin(l90,f11);
	
	
	POINT *origine = creer_point(0,0,0);
	POINT* destination = origine;
	
	destination->x= origine->x + f1002->valeur*cos(origine->direction*PI/180);
	destination->y= origine->y + f1002->valeur*sin(origine->direction*PI/180);
	
		
		
	printf("x2=%d  y2=%d  ",destination->x,destination->y);
	//writesvg(f100,fichier,origine);
	
	
	fclose(fichier); //renvoie 0 si OK et EOF(int) si fichier mal fermé

	
	return 0;
}
