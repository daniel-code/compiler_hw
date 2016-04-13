%{
#include<stdio.h>
#include<ctype.h>
unsigned charCount = 0, tokenCount = 0, lineCount = 1 ,position = 0;
%}	
int	[\+\-]?[1-9]*[0-9]
wint	[\+\-]*[0-9]*[0-9]
real	[\+\-]?(([0-9]+)|([0-9]*\.[0-9]+)([eE][\-\+]?[0-9]+)?)
rword	{PROGRAM}|{VAR}|{IF}|{THEN}|{ELSE}|{BEGIN}|{END}|{WHILE}|{FOR}|{DO}|{TO}|{FUNCTION}|{PROCEDURE}
id	[A-Za-z_][A-Za-z_0-9]+
wid 	[A-Za-z_0-9]*{symbol}*[A-Za-z_0-9{symbol}]+
space 	[ ]
eol 	\n
symbol	[\?\*\+\|\(\)\^\$\.\[\]\{\}\"\\#%&/]

PLUS        [\+]
MINUS       [\-]
TIMES       [\*]
BY          [/]
ASSIGN      :=
BINARYOP    {PLUS}|{MINUS}|{TIMES}|{BY}|{ASSIGN}
SEPARATOR   [,:;\.]
PROGRAM     [Pp][Rr][Oo][Gg][Rr][Aa][Mm]
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
LETTER      [A-Za-z]
DIGIT       [0-9]
ID          {LETTER}({LETTER}|{DIGIT})*
INTEGER     ({PLUS}|{MINUS})?{DIGIT}+
REAL        {INTEGER}(\.({DIGIT})*)?([eE]{INTEGER})?
COMMENT     "{"[^}\n]*"}"







%%
{int}		{ test_int();}
{wint}		{ test_wint();}
{real}		{ test_real();}
{rword}		{ test_rword();}
{id}		{ test_id();}
{wid}		{ test_wid();}

{space} 	{}
{eol}   	{lineCount++;position = 0;}

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
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"int\" \n", lineCount, position , yytext);

}
void test_wint()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"int\" \n", lineCount, position , yytext);
}
void test_real()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"real number\" \n", lineCount, position , yytext);
}
void test_rword()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved word\" \n", lineCount, position , yytext);	
}
void test_id()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\" \n", lineCount, position , yytext);
}
void test_wid()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\" \n", lineCount, position , yytext);
}








