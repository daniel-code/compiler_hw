%{
#include<stdio.h>
#include<ctype.h>

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
void test_symbol();


%}	
INTEGER	[\+\-]?([0-9]|[1-9][0-9]+)
wINTEGER [\+\-]*[0-9]+
REAL	({INTEGER}|({INTEGER}\.([0-9]*[1-9]|[0])))([eE]{INTEGER}+)?
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
{INTEGER}	{ test_int();}
{wINTEGER}	{ test_wint();}
{REAL}		{ test_real();}
{wREAL}		{ test_wreal();}
{PROGRAM}|{VAR}|{IF}|{THEN}|{ELSE}|{BEGIN}|{END}|{WHILE}|{FOR}|{DO}|{TO}|{FUNCTION}|{PROCEDURE}		{ test_rword();}
{ID}		{ test_id();}
{wID}		{ test_wid();}
{COMMENT}{COMMENT}*	{ test_comment();}
{COMMENT}{SYMBOL} {test_wcomment();}
{STRING}	{ test_string();}
{SYMBOL}	{ test_symbol();}


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
void test_wreal()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"real number\" \n", lineCount, position , yytext);
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
	if(yyleng<=30)
	printf("Line: %d, 1st char: %d, \"%s\" is an \"ID\" \n", lineCount, position , yytext);
	else
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\" \n", lineCount, position , yytext);
}
void test_wid()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is an invalid \"ID\" \n", lineCount, position , yytext);
}
void test_comment()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"comment\" \n", lineCount, position , yytext);		
}
void test_wcomment()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"wrong comment\" \n", lineCount, position , yytext);
}
void test_string()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	int i = 0;
	while(i < yyleng)
	{
		if(yytext[i]==(char)34)
		yytext[i]=(char)39;
		i++;
	}
	printf("Line: %d, 1st char: %d, %s is a \"string\" \n", lineCount, position , yytext);
}
void test_symbol()
{
	tokenCount++;
	charCount += yyleng;
	position++;
	printf("Line: %d, 1st char: %d, \"%s\" is a \"symbol\" \n", lineCount, position , yytext);	
}







