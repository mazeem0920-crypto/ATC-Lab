%{
#include <stdio.h>
%}

DIGIT [0-9]
ID [a-zA-Z_][a-zA-Z0-9_]*
KEYWORD (if|else|while|for|return|int|float|double|char|void)
OP [\+\-\*/=<>!&|]+ 

%%
{KEYWORD}   { printf("Keyword: %s\n", yytext); }
{ID}        { printf("Identifier: %s\n", yytext); }
{DIGIT}+    { printf("Number: %s\n", yytext); }
{OP}        { printf("Operator: %s\n", yytext); }
[ \t\r\n]+  ;
.           { printf("Unknown: %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
}

int main(){
    yylex();
    return 0;
}