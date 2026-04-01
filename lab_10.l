%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[ \t\r\n]+      ;
[0-9]+           { yylval = atoi(yytext); return NUMBER; }
"+"            { return PLUS; }
"-"            { return MINUS; }
"*"            { return MUL; }
"/"            { return DIV; }
"("            { return LPAREN; }
")"            { return RPAREN; }
";"            { return SEMI; }
"="            { return ASSIGN; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval = strdup(yytext); return ID; }
.               { return yytext[0]; }
%%

int yywrap(void) { return 1; }
