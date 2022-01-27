%option noyywrap

%{
#include "global.h"
#include "parser.h"
int lineno = 1;
%}

/*regular definitions*/
delim	[ \t]
newline	\n
digit	[0-9]
number	{digit}+
alpha	[A-Za-z]
id	{alpha}({alpha}|{digit})*

%%
{delim}		{}

{newline}	{
			lineno++; 
		}

{number}	{
	  		yylval = atoi(yytext);
	  		return NUM;
		}

{id}		{
			int p = 0;
			p = lookup (yytext);
			if (p == 0)
			p = insert (yytext, ID);
			yylval = p;
			return symtable[p].token;
		}

<<EOF>>		{
			return DONE;
		}

.		{
			yylval = NONE;
			return yytext[0];
		}
%%

int lexan() {
return yylex();
}

