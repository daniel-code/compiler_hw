%{
#include<stdio.h>
#include<ctype.h>
#include "y.tab.h"
unsigned charCount = 0, tokenCount = 0, lineCount = 1 ,position = 0;

void test_int();
void test_wint();
void test_real();
void test_wreal();
void test_rword();
void test_id();
void test_wid();
void test_comment();
void test_wcomment();
void test_string();
void test_wstring();
void test_symbol();


%}

PLUS        [\+]
MINUS       [\-]
TIMES       [\*]
BY          [/]
ASSIGN      :=|=
BRACKETS    [\(\)]

INTEGER	[\+\-]?([0-9]|[1-9][0-9]+)
wINTEGER [\+\-]*[0-9]+
REAL	({INTEGER}|({INTEGER}\.([0-9]*[1-9]|[0])))([eE]{INTEGER}+)?
wREAL	[\+\-]?((([0-9]+)|([0-9]*\.[0-9]*))([eE][\-\+]?(([0-9]+)|([0-9]*\.[0-9]*)))?)
ID	([A-Za-z_][A-Za-z_0-9]+|[A-Za-z])
wID 	([0-9]*{SYMBOL}*{ID})|({ID}{SYMBOL}*{ID})
COMMENT "(*"([^\*]|[\*]+[^\*)])*[\*]+")"
sSTRING	\'(\\.|[^\'])*\'
SYMBOL	[\?\|\^\$\.\[\]\{\}\"\\#%&/@;:,]|{PLUS}|{MINUS}|{TIMES}|{BY}|{ASSIGN}

space 	[ ]
eol 	[\r][\n]|[\n]

PROGRAM     [Pp][Rr][Oo][Gg][Rr][Aa][Mm]
INT         [Ii][Nn][Tt][Ee][Gg][Ee][Rr]
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
FLOAT	    [Ff][Ll][Oo][Aa][Tt]
STRING      [Ss][Tt][Rr][Ii][Nn][Gg]






%%
{PLUS}|{MINUS}|{TIMES}|{BY}|{ASSIGN}|{BRACKETS}	{test_symbol();}
{INTEGER}	{ test_int();return(INTEGER);}
{wINTEGER}	{ test_wint();}
{REAL}		{ test_real();}
{wREAL}		{ test_wreal();}
{PROGRAM}|{INT}|{VAR}|{IF}|{THEN}|{ELSE}|{BEGIN}|{END}|{WHILE}|{FOR}|{DO}|{TO}|{FUNCTION}|{PROCEDURE}|{FLOAT}|{STRING}		{ test_rword();}
{ID}		{ test_id();}
{wID}		{ test_wid();}
{COMMENT}*	{ test_comment();}
{COMMENT}({SYMBOL}|{BRACKETS})+ {test_wcomment();}
{sSTRING}*	{ test_string();}

[\'][^ \t\r\n\']*	{ test_wstring();}

{SYMBOL}	{ test_symbol();}


{space} 	{position ++;}
{eol}   	{lineCount++;position = 0;}


.           printf( "Unrecognized character: %s\n", yytext );
%%
main(){
	printf("\n\n-----Scanner start-----\n\n");
	yylex();
	printf("\n-----Scanner end-----\n\n");
	printf("The number of characters: %d\n",charCount);
	printf("The number of tokens: %d\n", tokenCount);
	printf("The number of lines: %d\n", --lineCount);
	return 0;
 }
void test_int()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"int\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_wint()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"int\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_real()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"real number\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_wreal()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"real number\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_rword()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved word\" \n", lineCount, position , yytext);	
	position += yyleng;
}
void test_id()
{
	tokenCount++;
	charCount += yyleng;
	if(yyleng<=30)
	printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\" \n", lineCount, position , yytext);
	else
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_wid()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_comment()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\" \n", lineCount, position , yytext);		
	position += yyleng;
}
void test_wcomment()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"wrong comment\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_string()
{
	tokenCount++;
	charCount += yyleng;
	int i = 0;
	while(i < yyleng)
	{
		if(i>0&&i<yyleng-1&&yytext[i]==(char)39&&yytext[i+1]==(char)39)
		{
			int j = i;			
			for(j;j<yyleng-1;j++)
			{
			yytext[j]=yytext[j+1];
			}
			yytext[yyleng-1]=(char)0;
		}
		i++;
	}
	printf("Line: %d, 1st char: %d, \"%s\" is a \"string\" \n", lineCount, position , yytext);
	position += yyleng;
}
void test_wstring()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"wrong string\" \n", lineCount, position , yytext);	
	position += yyleng;
}
void test_symbol()
{
	tokenCount++;
	charCount += yyleng;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\" \n", lineCount, position , yytext);	
	position += yyleng;
}
