%{
#include "global.h"

int yylex(void);
void yyerror (char const *s) {
   fprintf (stderr, "bison: %s\n", s);
}


%}

%token NONE
%token NUM
%token DIV
%token MOD
%token ID
%token DONE

%%

start :	list DONE
		;
list :	expr ';' list
		| %empty
		;
expr:	expr '+' term {emit ('+', NONE);}
		| expr '-' term {emit ('-', NONE);}
		| term
		;
term:	term '*' factor {emit ('*', NONE);}
		| term '/' factor {emit ('/', NONE);}
		| term DIV factor {emit (DIV, NONE);}
		| term MOD factor {emit (MOD, NONE);}
		| factor
		;
factor:	'(' expr ')'
		| ID {emit (ID, $1);}
		| NUM {emit (NUM, $1);}
		;

%%

void parse() {
	yyparse();
}
