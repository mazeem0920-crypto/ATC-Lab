%{
#include <stdio.h>
int lines=0, words=0, chars=0;
int inword=0;
%}

%%
.   { chars++; if(yytext[0]=='\n') lines++; if(yytext[0]==' '||yytext[0]=='\n'||yytext[0]=='\t'){ inword=0; } else if(!inword){ words++; inword=1; } }
%%

int yywrap(void) { return 1; }

int main(){
    yylex();
    printf("lines=%d words=%d chars=%d\n", lines, words, chars);
    return 0;
}