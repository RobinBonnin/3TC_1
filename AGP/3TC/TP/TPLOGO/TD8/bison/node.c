#include <stdio.h>
#include <stdlib.h>
#include "node.h"


/*--------------------------------------------------------         
                CREATION D'UN NOEUD
--------------------------------------------------------*/
NODE *creerNODE(int type,int valeur,NODE *fg,NODE *fd)
{
  NODE *x;

  x=(NODE *)malloc(sizeof(NODE));

  x->type=type;
  x->val=valeur;

  x->fd=fd;
  x->fg=fg;

  return (x);
}


/*--------------------------------------------------------         
                AFFICHAGE D'UN ARBRE
--------------------------------------------------------*/
void afficherNode(NODE *root)
{
  if (root==NULL) return;
  if (root->type!=NODE_ENTIER)
    {
      afficherNode(root->fg);
    }
  switch(root->type)
    {
    case  NODE_ENTIER:
      printf(" %d ",root->val);
      break;
    case  NODE_PLUS:
      printf(" + ");
      break;
   case  NODE_MOINS:
      printf(" - ");
      break;
   case  NODE_MULT:
      printf(" * ");
      break;
   case  NODE_DIV:
      printf(" / ");
      break;
    default:
      printf(" ? ");
      break;
    }
  if (root->type!=NODE_ENTIER)
    {
      afficherNode(root->fd);
    }
}

/*--------------------------------------------------------         
     EVALUATION DE L'EXPRESSION ARITHMETIQUE D'UN ARBRE
--------------------------------------------------------*/
int evalNode(NODE *root)
{int  resg, resd, res;

  if (root==NULL) return 0;
  if (root->type!=NODE_ENTIER)
    {
      resg=evalNode(root->fg);
    }
  if (root->type!=NODE_ENTIER)
    {
      resd=evalNode(root->fd);
    }

  switch(root->type)
    {
    case  NODE_ENTIER:
      res=root->val;
      break;
    case  NODE_PLUS:
      res=resg+resd;
      break;
   case  NODE_MOINS:
     res=resg-resd;
     break;
    case  NODE_MULT:
      res=resg*resd;
      break;
    case  NODE_DIV:
      res=resg/resd;
      break;
    default:
      res=0;
      break;
    }
}


      

