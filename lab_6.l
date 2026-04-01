%{
#include <stdio.h>
#include "y.tab.h"
/* For YACC ambiguity checking we just tokenize grammar symbols. */
%}

%%
[ \t\r\n]+      ;
"%start"        { return START; }
"|"            { return OR; }
":"            { return COLON; }
";"            { return SEMI; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENT; }
.               { return yytext[0]; }
%%

int yywrap(void) { return 1; }
