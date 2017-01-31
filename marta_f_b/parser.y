%{
	#include<stdlib.h>
	#include <stdio.h>
	extern int yylex();
	extern int yylineno,yychar;
	extern char *yytext;
	extern FILE *yyin;

%}
%union
{
	char *ivalue;
	int integer_t;
	float float_t;
};
%token <ivalue> IDENTIFIER
%token IF
%token ELSE
%token <ivalue> STRING 
%token ASSIGNEQUAL
%token ASSIGNDOT
%token PARENI
%token PAREND
%token LLAVEI
%token LLAVED
%token SEPARATOR
%token COMPARE
%token TYPE
%token <integer_t>INTEGER 
%token <float_t>FLOAT
%token VARIABLE
%token PROGRAM
%token COMA
%token PUNTOYCOMA
%token OPUNO
%token OPDOS
%token DISPLAY
%start Program
%%
Program:
	PROGRAM IDENTIFIER PUNTOYCOMA Paux;
Paux:
	Bloque | Vars Bloque;
Vars:
	VARIABLE Vaux;
Vaux:
	IDENTIFIER Vaux2;
Vaux2:
	COMA Vaux | ASSIGNDOT TYPE PUNTOYCOMA | ASSIGNDOT TYPE PUNTOYCOMA Vaux;
Expresion:
	Exp | Exp Eaux2;
Eaux2:
	COMPARE Exp;
Exp:
	Termino | Termino Eaux;
Eaux:
	OPUNO Exp;
Bloque:
	LLAVEI Baux;
Baux:
	LLAVED | Estatuto Baux;
Asignacion:
	IDENTIFIER ASSIGNEQUAL Expresion PUNTOYCOMA | error ASSIGNEQUAL Expresion PUNTOYCOMA {yyerror("No es una asignacion valida");exit(1);}
	;
Escritura:
	DISPLAY PARENI Escaux PAREND PUNTOYCOMA;
Escaux: 
	Expresion | Expresion Escaux2 | STRING | STRING Escaux2;
Escaux2:
	COMA Escaux;
Estatuto:
	Asignacion | Condicion | Escritura;
Condicion:
	IF PARENI Expresion PAREND Bloque Caux;
Caux:
	ELSE Bloque PUNTOYCOMA | PUNTOYCOMA;
Termino:
	Factor | Factor Taux;
Taux:
	OPDOS Termino| error Termino { yyerror("Operación no aceptada");exit(1);}
	;
Factor:
	 PARENI Expresion PAREND | Faux
	;
Faux:
	Varcte | OPUNO Varcte
	;
Varcte:
	IDENTIFIER | INTEGER | FLOAT | error{yyerror("Elemento faltante;");exit(1);};

%%

int yyerror(char *s){
	printf("El caracter %s en la linea %d es incorrecto.", yytext, yylineno);
	exit(1);
}

int main (int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yyparse();
	printf("Trabajando correctamente");
	return 1;
}