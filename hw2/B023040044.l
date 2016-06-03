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
BY          [/]
ASSIGN      :=
EQUAL       =
BRACKETS    [\(\)]

INT	[\+\-]?([0-9]|[1-9][0-9]+)
wINT    [\+\-]*[0-9]+
REAL	({INTEGER}|({INTEGER}\.([0-9]*[1-9]|[0])))([eE]{INTEGER}+)?
wREAL	[\+\-]?((([0-9]+)|([0-9]*\.[0-9]*))([eE][\-\+]?(([0-9]+)|([0-9]*\.[0-9]*)))?)
ID	([A-Za-z_][A-Za-z_0-9]+|[A-Za-z])
wID 	([0-9]*{SYMBOL}*{ID})|({ID}{SYMBOL}*{ID})
COMMENT "(*"([^\*]|[\*]+[^\*)])*[\*]+")"
sSTRING	\'(\\.|[^\'])*\'
SYMBOL	[\?\|\^\$\.\[\]\{\}\"\\#%&/@:,]|{PLUS}|{MINUS}|{TIMES}|{BY}|{ASSIGN}

space 	[ ]
eol 	[\r][\n]|[\n]

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






%%

{INT}		{display();return(INT);}



{PROGRAM}	{display();return(PROGRAM);}
{VAR}		{display();return(VAR);}
{INTEGER}	{display();return(INTEGER);}
{REALTYPE}	{display();return(REALTYPE);}
{ARRAY}		{display();return(ARRAY);}
{OF}		{display();return(OF);}

{ID}		{display();return(ID);}



";"		{display();return(';');}
"["		{display();return('[');}
"]"		{display();return(']');}
","		{display();return(',');}
"."		{display();return('.');}
":"		{display();return(':');}



{space} 	{position ++;printf("%s",yytext);}
{eol}   	{ lineCount++;position = 0;printf("\n");printf("Line %d:",lineCount);}


.           printf( "Unrecognized character: %s\n", yytext );
%%
void display()
{
	tokenCount++;
	charCount += yyleng;
	position += yyleng;
	currentChar=yytext;
	printf("%s",yytext);
}

