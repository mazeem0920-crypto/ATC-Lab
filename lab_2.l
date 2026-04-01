%{
#include <stdio.h>
%}

%%
"/*"([^*]|"*"+[^*/])*"*/"    ;
"//".*                          ;
.                                { putchar(yytext[0]); }
\n                               { putchar('\n'); }
%%

int yywrap(void) { return 1; }

int main(){
    yylex();
    return 0;
}