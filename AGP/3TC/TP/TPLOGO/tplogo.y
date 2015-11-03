%{
#include <stdio.h>
#include "fonctions_logo.h"

void yyerror(const char *str){
	fprintf(stderr, "erreur détectée dans le programme LOGO : %s\n",str);
}

int yywrap(){
	return 1 ;
}

%} //règles

%token VALUE
%token FORWARD
%token REPEAT
%token LEFT
%token RIGHT


//type de yylval
%union {
    NODE* NODE_TYPE;
    int val;
 };

//types
%type <val> VALUE
%type <NODE_TYPE> INST PROG FILE
%type <NODE_TYPE> FORWARD LEFT REPEAT RIGHT


%% 

FILE : PROG
{
	root=$1;

}

//programme
PROG: INST
{
	$$=$1;

}
|PROG INST
{
	insert_fin($1,$2);
	$$=$1;
}



//instructions
INST : FORWARD VALUE 
{
	$$= init_elem("FORWARD",$2,NULL);
}

| LEFT VALUE 
{
	$$= init_elem("LEFT",$2,NULL);
}

|RIGHT VALUE 
{
	$$= init_elem("RIGHT",$2,NULL);
}

| REPEAT VALUE '['PROG']'
{
	$$= init_elem("REPEAT",$2,$4);
}



%% 
// code


main(){
	yyparse();
	afficher_programme(root);
}

