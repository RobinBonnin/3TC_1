/*--------------------------------------------------------         
                  DEFINITIONS
--------------------------------------------------------*/
%{
#include <stdio.h>
#include <stdlib.h> 
#include "node.h"

int yywrap(){
  return 1;
}

int yyerror()
{
  printf("\n erreur !\n");
  exit(1);
}

%}   

// symbole terminaux
%token   ENTIER PLUS MOINS MULT DIV


//type de yylval
%union {
    NODE *NODE_TYPE;
    int val;
 };

//type des  terminaux
%type  <val> ENTIER
%type  <NODE_TYPE> PLUS MOINS MULT DIV
//type des  non-terminaux
%type <NODE_TYPE> expression term factor


%%
/*--------------------------------------------------------         
                  GRAMMAIRE ANNOTEE
--------------------------------------------------------*/

expression : term
       {
	 root=$1;
       }

term : term PLUS factor
        {
	  $$=creerNODE(NODE_PLUS,0,$1,$3);
	}
  |    term MOINS factor
        {
	  $$=creerNODE(NODE_MOINS,0,$1,$3);
	}
  |    factor
       {
	 $$=$1;
       }

factor : factor MULT ENTIER
        {
	  $$=creerNODE(NODE_MULT,0,$1,creerNODE(NODE_ENTIER,$3,NULL,NULL));
	}
  |    factor DIV ENTIER
        {
	  $$=creerNODE(NODE_DIV,0,$1,creerNODE(NODE_ENTIER,$3,NULL,NULL));
	}
  |    ENTIER
       {
	 $$=creerNODE(NODE_ENTIER,$1,NULL,NULL);;
       }


%%
/*--------------------------------------------------------         
                  FONCTIONS MAIN
--------------------------------------------------------*/

int main(){

  yyparse();

   afficherNode(root); 
   printf("\n");
   printf("Qui vaut: %d\n",evalNode(root)); 
   printf("\n");

   return 0;
}


