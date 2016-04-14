%{
#include<stdio.h>
#include<ctype.h>

unsigned charCount = 0, tokenCount = 0, lineCount = 1 ,position = 0;
void show(int s);

%}	
INTEGER	[\+\-]?([0-9]|[1-9][0-9]+)
wINTEGER [\+\-]*[0-9]+
REAL	({INTEGER}|({INTEGER}\.([0-9]*[1-9]|[0])))([eE]({INTEGER}|({INTEGER}\.([0-9]*[1-9]|[0]))))?
wREAL	[\+\-]?((([0-9]+)|([0-9]*\.[0-9]*))([eE][\-\+]?(([0-9]+)|([0-9]*\.[0-9]*)))?)
ID	([A-Za-z_][A-Za-z_0-9]+|[A-Za-z])
wID 	([0-9]*{SYMBOL}*{ID})|({ID}{SYMBOL}*{ID})
COMMENT "(*"([^\*]|[\*]+[^\*)])*[\*]+")"
STRING	\'(\\.|[^\\'])*\'
SYMBOL	[\?\*\+\|\(\)\^\$\.\[\]\{\}\"\\#%&/@;]+

space 	[ ]
eol 	\n

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

%%
{INTEGER}	{ show(1);}
{wINTEGER}	{ show(2);}
{REAL}		{ show(3);}
{wREAL}		{ show(4);}
{PROGRAM}|{VAR}|{IF}|{THEN}|{ELSE}|{BEGIN}|{END}|{WHILE}|{FOR}|{DO}|{TO}|{FUNCTION}|{PROCEDURE}		{ show(5);}
{ID}		{ show(6);}
{wID}		{ show(7);}
{COMMENT}+	{ show(8);}
{COMMENT}{SYMBOL} {show(9);}
{STRING}	{ show(10);}
{SYMBOL}	{ show(11);}


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
void show(int s)
{
	tokenCount++;
	charCount += yyleng;
	position++;
	switch(s)
	{
		case 1:	printf("Line: %d, 1st char: %d, \"%s\" is a \"int\" \n", lineCount, position , yytext);break;
		case 2:	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"int\" \n", lineCount, position , yytext);break;
		case 3:	printf("Line: %d, 1st char: %d, \"%s\" is a \"real number\" \n", lineCount, position , yytext);break;
		case 4:	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"real number\" \n", lineCount, position , yytext);break;
		case 5:	printf("Line: %d, 1st char: %d, \"%s\" is a \"reserved word\" \n", lineCount, position , yytext);break;
		case 6:	{
			if(yyleng<=30)
			printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\" \n", lineCount, position , yytext);
			else
			printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\" \n", lineCount, position , yytext);
			break;
			}
		case 7:	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\" \n", lineCount, position , yytext);break;
		case 8:	printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\" \n", lineCount, position , yytext);break;
		case 9:	printf("Line: %d, 1st char: %d, \"%s\" is a \"wrong comment\" \n", lineCount, position , yytext);break;
		case 10:{
			int i = 0;
			while(i < yyleng)
			{
				if(yytext[i]==(char)34)
				yytext[i]=(char)39;
				i++;
			}
			printf("Line: %d, 1st char: %d, %s is a \"string\" \n", lineCount, position , yytext);break;
			}		
		case 11:printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\" \n", lineCount, position , yytext);break;
	}
}
