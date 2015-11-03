%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *str){
	fprintf(stderr, "erreur : %s\n",str);
}

int yywrap(){
	return 1 ;
}

%} //règles

%token NUMBER
%token PLUS

%% 
SOM: EXPR
{
	fprintf(stdout, "somme : %d\n", $1);
	$$=$1;
}

EXPR: 	NUMBER
{
	$$=$1;
}
| NUMBER PLUS EXPR
{
	$$=$1+$3;
}



%%  // code
main(){
	yyparse();
}

