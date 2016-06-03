%{
#include <stdio.h>
#define RED "\033[0;32;31m"
#define PURPLE "\033[0;35m"
#define NONE "\033[m"
extern char *currentChar;
extern char *s[5];
extern unsigned stack_index;
extern unsigned charCount , tokenCount , lineCount  ,position ;
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
%token PROGRAM VAR INTEGER REALTYPE ARRAY OF
%token ID INT

%left '-' '+'
%left '*' DIV


%%

prog : PROGRAM prog_name ';' VAR dec_list ';' {}
prog_name : ID {}
dec_list : dec | dec_list ';' dec
dec : id_list ':' type
type : standtype | arraytype
standtype : INTEGER | REALTYPE
arraytype : ARRAY '['INT '.''.' INT']' OF standtype
id_list : ID | id_list ',' ID


%%

int main(){
printf("Line %d:",lineCount);
    yyparse();
    return 0;
}
void yyerror(char *str){

        fprintf(stderr,RED"error: bad\n"NONE);

}

