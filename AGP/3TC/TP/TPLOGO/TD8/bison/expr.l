%{
#include "node.h"
#include "expr.tab.h"
%}

%%

[1-9][0-9]*   { yylval.val=atoi(yytext); return ENTIER;}
"("        {return '(';}
")"        {return ')';}
\+        { return PLUS;}
\*        { return MULT;}
-        { return MOINS;}
\/        { return DIV;}

%%
