%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
[ \t\r\n]+      ;
"if"           { return IF; }
"else"         { return ELSE; }
"for"          { return FOR; }
"while"        { return WHILE; }
"("            { return LPAREN; }
")"            { return RPAREN; }
"{"            { return LBRACE; }
"}"            { return RBRACE; }
";"            { return SEMI; }
(<=|>=|==|!=|<|>)   { return RELOP; }
[0-9]+               { yylval.intval = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
.               { return yytext[0]; }
%%

int yywrap(void) { return 1; }
