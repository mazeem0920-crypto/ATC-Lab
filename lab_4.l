%{
#include <stdio.h>
#include <regex.h>

regex_t re;
int status;
%}

%%
[ \t\r\n]+     ;
[^\n]+          { 
                    if (regcomp(&re, yytext, REG_EXTENDED) != 0) {
                        printf("Invalid regex: %s\n", yytext);
                    } else {
                        printf("Valid regex: %s\n", yytext);
                        regfree(&re);
                    }
                  }
%%

int yywrap(void) { return 1; }

int main(){
    yylex();
    return 0;
}