%{
#include <stdio.h>
%}
%%
[a-zA-Z][a-zA-Z0-9_]* printf("Ident: %s \n",yytext);
-?[1-9][0-9]*|0 printf("Entier\n");
%%
