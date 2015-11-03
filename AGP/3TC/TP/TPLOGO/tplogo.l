%{
#include <stdio.h>
#include "fonctions_logo.h"
#include "tplogo.tab.h"
#include <stdlib.h>

%} 

%%  
FORWARD				return FORWARD;
LEFT				return LEFT;
RIGHT				return RIGHT;
REPEAT				return REPEAT;
[0-9]+ 				{yylval.val=atoi(yytext); return VALUE;}
\]					return ']';
\[					return '[';
\n 					/* On ignore les sauts de ligne*/;
[\t]+				/* On ignore les tabulations*/;
%%
