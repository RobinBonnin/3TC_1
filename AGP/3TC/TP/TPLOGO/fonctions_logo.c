/************************************************************************************
* 										fonctions_logo.c																																
* 																				
* 		Bibliothèque de fonctions sur la structure intermédiaire (Partie 1 tp logo)													
* 		@author : mbakkali
* 																			
*************************************************************************************/

#include "fonctions_logo.h"
#include <math.h>



POINT *creer_point(double x, double y, double direction){
	POINT *point =malloc(3*sizeof(double));
	point->x=x;
	point->y=y;
	point->direction=direction;
	return point;
}



NODE *init_elem(char* instruction, int valeur, NODE* repeat){
	
	NODE *new_elem = (NODE*)malloc(sizeof(NODE));
	
	//controle de l'attribution de la memoire
	if(new_elem == NULL){
		printf("Erreur à la ligne %d, memoire non attribuée\n", __LINE__);
	}
	
	//Initialisation des attibuts de new_elem
	new_elem->valeur=valeur;
	new_elem->instruction=instruction;
	new_elem->repeat=repeat;
	new_elem->suivant = NULL;

	
	return new_elem;
}


void insert_debut(NODE *root, NODE *node){
	
	//controle de l'attribution de la memoire
	if(root == NULL || node == NULL){
		printf("Erreur à la ligne %d, memoire non attribuée\n", __LINE__);
	}
	
	//on rattache les pointeurs 
	node->suivant = root;
	root = node;
}



void insert_fin(NODE *root, NODE *node){
	
	//controle
	if(root == NULL || node == NULL){
		printf("Erreur à la ligne %d, memoire non attribuée\n", __LINE__);
	}

	
	NODE *curseur = root;
	
	while(curseur->suivant != NULL){
		curseur=curseur->suivant;
	}
	
	curseur->suivant=node;
	
}

/* Fonction supprime_debut
 * Supprime le premier NODE de la NODE
 * @Param : un node
 * Return : 
 */
void supprimer_debut(NODE *root){
	
	//on check si la root n'est pas vide
	if(root == NULL){
		printf("La root est vide\n");
	}
	
	if(root != NULL){
		NODE *aSupprimer = root;
		root = root->suivant;
		free(aSupprimer);
	}
}



/* Fonction supprime_fin
 * Supprime le dernier NODE de la NODE
 * @Param : un node
 * Return : 
 */
void supprimer_fin(NODE *root){
	
	//controle
	if(root == NULL){
		printf("Erreur à la ligne %d, memoire non attribuée\n", __LINE__);
	}
	
	NODE *curseur = root;
	NODE *previous;
	previous->suivant = curseur;
	
	while(curseur->suivant != NULL){
		curseur=curseur->suivant;
		previous=previous->suivant;
	}
	
	free(curseur);
	previous->suivant=NULL;
	
	
}



void afficher_node(NODE *node){
	//on check si le node est NULL
	if(node->instruction == NULL ){
		printf("Le node est vide (pas d'instruction) \n");
	}
	if(node->valeur <= 0 ){
		printf("Le node est incomplet (valeur manquante) \n");
	}
	
	else{
		printf("%s %d ",node->instruction,node->valeur);
	}	
}


/* Fonction pretty_print
 * aide à l'afficheur principal
 * Cette fonction est la même que afficher_programme sauf qu'elle imprime tout sur la meme ligne
 * Cette fonction ne gère pas les doubles imbrications de repeat
 * @Param : une tete de root de type NODE*
 * Return : void
 */
void pretty_print(NODE *node){
	
	NODE *curseur = NULL;
	curseur = node;
	
	while(curseur != NULL){
		
		if(curseur->repeat != NULL){
			printf("REPEAT %d[\n\t  ", curseur->valeur);
			pretty_print(curseur->repeat);
			printf("]");
		}
		
		else {
			
			//controle d'affichage
			if(curseur->instruction == NULL ){
			printf("Le node est vide (pas d'instruction) \n");
			}
			if(curseur->valeur <= 0 ){
			printf("Le node est incomplet (valeur manquante) \n");
			}
			
		printf("%s %d",curseur->instruction,curseur->valeur);
		}
		curseur=curseur->suivant;
	}
}

/* Fonction afficher_programme
 * affiche une root a partir du debut
 * Attention cette fonction utilise la fonction auxilliaire pretty_print(NODE*)
 * @Param : une tete de root de type NODE*
 * Return : void
 */
void afficher_programme(NODE *root){
	
	printf("\n");
	
	
	
	//mise en place du curseur principal qu'on initialise avec la tête de root
	NODE *curseur = NULL;
	curseur = root;
	
		
	//Tant qu'on est pas en fin de root
	while(curseur != NULL){
		
	//on check si le node est NULL
			if(curseur->instruction == NULL ){
			curseur=curseur->suivant;
			}
			if(curseur->valeur <= 0 ){
				curseur=curseur->suivant;
			}
		
	
		
		/* Si le curseur rencontre une sous root de type REPEAT -> 2 possibilités
		 * Soit il y'a DEUX REPEAT embriqués au minimum l'uns dans l'autre
		 * Soit il n'y a qu'un seul REPEAT avec une autre fonction imbriquée dedans (qui n'est pas un repeat)
		 */
		if(curseur->repeat != NULL){
			
			/*Premier cas de figure : il y'en a au moins 2 à la suite
			 * On initialise un deuxième curseur (le suivant du premier) 
			 * il va vérifier la succession de REPEAT imbriqués 
			 */

			NODE *curseur2 = curseur->suivant;
			
			while(curseur2->repeat !=NULL){
				printf("REPEAT %d[\n\t  ", curseur->valeur);
				//pretty_print va imprimer tout en ligne : cas d'un repeat
				pretty_print(curseur->repeat);
				printf("\n]");
				//On a pas besoin d'incrementer le deuxieme curseur qui est lié au premier
		    }
		    
		    
		    /*Deuxième cas : seul REPEAT
			 * On imprime avec pretty_print et on ferme le crochet avec un saut de ligne vu que l'instruction
			 * suivante n'est pas un repeat
			 */
			 
			printf("REPEAT %d [\n\t  ", curseur->valeur);
			pretty_print(curseur->repeat);
			printf("]\n");
		    
		    
		}
		/* Si le curseur ne rencontre pas une sous root de type REPEAT -> il continue a sauter des lignes après 
		 * chaque instruction
		 */
		else printf("%s %d\n",curseur->instruction,curseur->valeur);
	
		//incrementation du curseur de la première boucle while	
		curseur=curseur->suivant;	
	}
	
	
}


/* Fonction effacer_root
 * Efface la root de la memoire
 * @Param : un node 
 * Return : void
 */
void effacer_root(NODE *root){
	
	NODE *tempnext;
	NODE *temp =root;
	
	if(root==NULL){
		printf("La root est vide");
	}
	
	while(temp != NULL){
		tempnext = temp->suivant;
		free(temp);
		temp=tempnext;
		
	}
}


void create_svg(){
	
/* Creation fichier + Controle */
	FILE *fichier = fopen("logo.svg","r+");
	
	if(fichier == NULL) {
	printf("impossible d'ouvrir le fichier\n");
	}
	printf("Fichier ouvert avec succès\n");
	
	fputs("<svg version=\"1.1\" baseProfile=\"full\" xmlns=\"http://www.w3.org/2000 svg\">",fichier);

}


/* Fonction creerline pour donner le point de destination d'une ligne
 * @param : NODE* de l'arbre initial, FILE* pour le fichier de destination et un POINT
 */
POINT *point_dest(POINT* origine, int value){
	POINT* destination = origine;
	
	destination->x= origine->x + value*cos(origine->direction*PI/180) ;
	destination->y= origine->y + value*sin(origine->direction*PI/180);
	
	return destination;
}


/* Fonction Write SVG qui écrit dans un fichier en SVG les commandes pour tracer
 * @param : NODE* de l'arbre initial, FILE* pour le fichier de destination et un POINT
 */
void writesvg(NODE* root, FILE* fichier, POINT* origine){
		
	if(fichier != NULL && root != NULL){
		
		if(strcmp(root->instruction,"FORWARD")==0){
		POINT *dest =point_dest(origine,root->valeur);
		double xdest = (dest)->x;
		double ydest = (dest)->y;
			
			
			char *chaine= malloc(sizeof(chaine));
			sprintf(chaine,"<line x1=\"%.3f\" y1=\"%.3f\" x2=\"%.3f\" y2=\"%.3f\" stroke=\"red\" />\n",origine->x,origine->y, xdest,ydest);
			printf("%s", chaine);
			fputs(chaine,fichier);
			origine= dest;
			
		}
		
		else if(strcmp(root->instruction,"RIGHT")==0){
			origine->direction += (root->valeur)*PI/180;
		
		}
		
		else if(strcmp(root->instruction,"LEFT")==0){
			origine->direction += (root->valeur)*PI/180;
			
		}
		
		/*else if(strcmp(root->instruction,"REPEAT")==0){
			int i;
			for(i=0; i<= root->valeur; i++){
				writesvg(root->repeat,fichier,origine);
				root->repeat = (root->repeat)->suivant;
			}
			return origine;
		}
		*/
		else {
			printf("Erreur d'instruction !");
		}
	
	}
	
}



