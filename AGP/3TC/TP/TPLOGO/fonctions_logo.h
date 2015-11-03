/************************************************************************************
* 										fonctions_logo.h																																
* 																				
* 		Bibliothèque de fonctions sur la structure intermédiaire (Partie 1 tp logo)												
* 		@author : mbakkali
* 																			
*************************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define PI 3.14159265358979323846


/****************************** Structures ******************************/

/* On définit une structure NODE 
 * pour éviter de réecrire struct NODE on utilise typedef
 * pour acceder à un attribut elem->valeur si elem est un pointeur de NODE et elem.valeur si elem est un type NODE
 */


typedef struct POINT POINT ;
struct POINT{
	
	double direction;
	double x;
	double y;
	
};







typedef struct NODE NODE;
struct NODE{
	
	char* instruction;
	int valeur;
	NODE *suivant;
	NODE *repeat; 
	
};



/****************************** Prototypes ******************************/
POINT *creer_point(double x, double y, double direction);

static NODE* root;

NODE *init_elem(char* instruction, int valeur, NODE* repeat);

void insert_debut(NODE *root, NODE *node);
void insert_fin(NODE *root, NODE *node);

void supprimer_debut(NODE *root);
void supprimer_fin(NODE *root); //marche pas

void afficher_node(NODE *node);
void pretty_print(NODE *node);
void afficher_programme(NODE *root);

void effacer_root(NODE *root);//marche pas




void writesvg(NODE* root, FILE* fichier, POINT* origine);


POINT *point_dest(POINT* origine, int value);

