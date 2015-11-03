#ifndef _NODE_H
#define _NODE_H

#define NODE_ENTIER   0
#define NODE_PLUS    1
#define NODE_MOINS     2
#define NODE_MULT    3
#define NODE_DIV   4

typedef struct node {

  int              type ;          /* type de noeud          */
  int             val;                 /* variable               */
  struct node      *fg;                 /* fils gauche            */
  struct node      *fd;                 /* fils droit             */

} NODE ;
 

static NODE *root;     

NODE *creerNODE(int type,int valeur,NODE *fg,NODE *fd);
void afficherNode(NODE *root);
int evalNode(NODE *root);

#endif
