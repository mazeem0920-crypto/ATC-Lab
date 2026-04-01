%{
#include "y.tab.h"   /* for token definitions from YACC grammar */
%}

%%
[ \t\r]+      ;
\n              { return '\n'; }
[0-9]+         { yylval.intval = atoi(yytext); return NUMBER; }
"+"          { return PLUS; }
"-"          { return MINUS; }
"*"          { return MUL; }
"/"          { return DIV; }
"("          { return LPAREN; }
")"          { return RPAREN; }
.             { return yytext[0]; }
%%

int yywrap(void) { return 1; }
