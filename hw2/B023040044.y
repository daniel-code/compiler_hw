%{
#include <stdio.h>
#include <string.h>
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
int i;
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



%token PROGRAM VAR INTEGER REALTYPE ARRAY OF myBEGIN END IF THEN READ WRITE FOR DO TO
%token ID INT REAL
%token ASSIGN RELOP
%left '-' '+'
%left '*' DIV

%%

prog 		: PROGRAM prog_name ';' VAR dec_list ';' myBEGIN stmt_list ';' END '.'
prog_name 	: ID 
dec_list	: dec | dec_list ';' dec
dec 		: id_list ':' type
type 		: standtype | arraytype
standtype 	: INTEGER | REALTYPE
arraytype 	: ARRAY '['INT '.''.' INT']' OF standtype
id_list 	: ID | id_list ',' ID
stmt_list	: stmt | stmt_list ';' stmt
stmt		: assign | read | write | for | ifstmt 
assign		: varid ASSIGN simpexp
ifstmt		: IF '(' exp ')' THEN body
exp		: simpexp | exp RELOP simpexp 
simpexp		: term | simpexp '+' term | simpexp '-' term 
term		: factor | term '*' factor | term DIV factor 
factor		: varid | INT | REAL | '(' simpexp ')'
read		: READ '(' id_list ')'
write		: WRITE '(' id_list')'
for		: FOR index_exp DO body 
index_exp	: varid ASSIGN simpexp TO exp | error {yyerrok;yyclearin;}
varid		: ID | ID '[' simpexp ']'
body		: stmt | myBEGIN stmt_list ';' END






%%

int main(){
    printf("Line %d:",lineCount);
    yyparse();
    printf("\n");
    return 0;
}
void yyerror(char *str){
	fprintf(stderr,RED"Line %d: 1st char: %d, syntax error at \"%s\"\n"NONE, lineCount, position , currentChar);
}


