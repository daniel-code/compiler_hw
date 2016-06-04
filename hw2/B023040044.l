%{
#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include "y.tab.h"
unsigned charCount = 0, tokenCount = 0, lineCount = 1 ,position = 0;
unsigned stack_index = 0;
char *currentChar;
void display();
%}

PLUS        [\+]
MINUS       [\-]
TIMES       [\*]
DIV         [/]
ASSIGN      :=
RELOP       [>=<]|>=|<=|<>
BRACKETS    [\(\)]

PROGRAM     [Pp][Rr][Oo][Gg][Rr][Aa][Mm]
INTEGER     [Ii][Nn][Tt][Ee][Gg][Ee][Rr]
VAR         [Vv][Aa][Rr]
IF          [Ii][Ff]
THEN        [Tt][Hh][Ee][Nn]
ELSE        [Ee][Ll][Ss][Ee]
BEGIN       [Bb][Ee][Gg][Ii][Nn]
END         [Ee][Nn][Dd]
WHILE       [Ww][Hh][Ii][Ll][Ee]
FOR         [Ff][Oo][Rr]
DO          [Dd][Oo]
TO          [Tt][Oo]
FUNCTION    [Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]
PROCEDURE   [Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee]
REALTYPE    [Ff][Ll][Oo][Aa][Tt]
STRING      [Ss][Tt][Rr][Ii][Nn][Gg]
OF	    [Oo][Ff]
ARRAY	    [Aa][Rr][Rr][Aa][Yy]
READ	    [Rr][Ee][Aa][Dd]
WRITE       [Ww][Rr][Ii][Tt][Ee]


INT	([0-9]|[1-9][0-9]+)
REAL	({INT}|({INT}\.([0-9]*[1-9]|[0])))([eE]{INT}+)?
ID	([A-Za-z_][A-Za-z_0-9]+|[A-Za-z])
space 	[ ]
eol 	[\r][\n]|[\n]


%%
{PLUS}       	{ display();return('+');}
{MINUS}      	{ display();return('-');}
{TIMES}     	{ display();return('*');}
{DIV}        	{ display();return(DIV);}
{ASSIGN}	{ display();return(ASSIGN);}
";"		{ display();return(';');}
"["		{ display();return('[');}
"]"		{ display();return(']');}
","		{ display();return(',');}
"."		{ display();return('.');}
":"		{ display();return(':');}
"("		{ display();return('(');}
")"		{ display();return(')');}
{RELOP}		{ display();return(RELOP);}

{INT}		{ display();return(INT);}
{REAL}		{ display();return(REAL);}

{PROGRAM}	{ display();return(PROGRAM);}
{VAR}		{ display();return(VAR);}
{INTEGER}	{ display();return(INTEGER);}
{REALTYPE}	{ display();return(REALTYPE);}
{ARRAY}		{ display();return(ARRAY);}
{OF}		{ display();return(OF);}
{BEGIN}		{ display();return(myBEGIN);}
{END}		{ display();return(END);}
{IF}		{ display();return(IF);}
{THEN} 		{ display();return(THEN);}
{READ} 		{ display();return(READ);}
{WRITE} 	{ display();return(WRITE);}
{FOR}		{ display();return(FOR);}
{DO} 		{ display();return(DO);}
{TO}		{ display();return(TO);}

{ID}		{ display();return(ID);}

{space} 	{ position ++;printf("%s",yytext);}
{eol}   	{ lineCount++;position = 0;printf("\nLine %d:",lineCount);}

.		printf("Unrecognized : %s\n",yytext);
%%
void display()
{
	tokenCount++;
	charCount += yyleng;
	position += yyleng;
	currentChar=yytext;
	printf("%s",yytext);
}

