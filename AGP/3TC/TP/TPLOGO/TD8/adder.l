%{
#include <stdio.h>
#include "adder.tab.h"
#include <stdlib.h>

%} 

%%  
[0-9]+ 				yylval=atoi(yytext); return NUMBER;
\+ 					return PLUS;
\n 					;
[\t]				;
%%
