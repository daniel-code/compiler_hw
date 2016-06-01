%{
#include <stdio.h>
#define RED "\033[0;32;31m"
#define PURPLE "\033[0;35m"
#define NONE "\033[m"
extern char currentChar;
//you can specify your own yyerror
void yyerror(char *str);
char buffer[30];
/*
YACC provides a error token to handle the syntax error condition.
if you do not specify the error token, yyparse() will return when
the syntax error occurs(this means that your program will be terminated).
In other words, you have to specify the error token if you want to do error recovery.
*/
/*
You can find more examples of error handling if you google "yacc error handling"
*/
%}
%union{
int INTEGER;
};
%token <INTEGER> INTEGER
%type <dval> expression
%%


INT: {/*empty string*/}
    | INT expression'\n'  { printf(PURPLE"%d\n",$2);}
    | error '\n'{/*when syntax error occurs, yacc skips every token until it recognizes the next token(the newline) of error. You can see that error recovery will begin at next line. Use yyclearin macro to clear the old lookup token*/yyclearin;}
expression: expression {$$ = $1;/* $N references the value of token or type, N is determined by the position of the token*/}
%%

int main(){
    yyparse();
    return 0;
}
void yyerror(char *str){
    //By default, YACC calls yyerror() and pass "syntax errro" as a argument
    //I think this is not a good design, you can redesign it if you find some useful macros:)
    if(strcmp(str,"syntax error") == 0){
        fprintf(stderr,RED"error: %s at %c\n"NONE,str,currentChar);
    }else{
    //this handles "divide by zero" condition
        fprintf(stderr,RED"error: %s\n"NONE,str);
    }
}
