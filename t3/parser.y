%{
//	#include <stdlib.h>
	#include <stdio.h>
	extern int yylex();
	extern int yylineno
	extern int yychar;
	extern char *yytext;
	extern FILE *yyin;
%}

%union {
	char *ivalue;
	int integer_t;
	float float_t;
};

// Declaracion de Tokens
// Incluye los cambios hechos en las expresiones regulares 
%token IF
%token ELSE
%token PROGRAM
%token ESCRITURA
%token TIPO
%token <ivalue> ID
%token <integer_t>ENTERO 
%token <float_t>FLOTANTE
%token EXPRESION
%token PARENTESIS_IZQ
%token PARENTESIS_DER
%token <ivalue> STRING 
%token TERMINO
%token ASIGNACION
%token EXP
%token CORCHETE_IZQ
%token CORCHETE_DER
%token SEPARATOR
%token COMA
%token PUNTO_COMA
%token VAR

%start Program
%%

Program:
	PROGRAM ID PUNTO_COMA Vars Bloque
	| PROGRAM ID PUNTO_COMA Bloque;

//------------------------
Vars:
	VAR Vars2;
Vars2:
	ID Vars3;
Vars3:
	COMA Vars2
	| ASIGNACION TIPO PUNTO_COMA Vars2
	| ASIGNACION TIPO PUNTO_COMA;

//------------------------
Bloque:
	CORCHETE_IZQ Bloque2 CORCHETE_DER;
Bloque2:
	Estatuto | Estatuto Bloque2;

//------------------------
Estatuto:
	Asignacion | Condicion | Escritura;

//------------------------
Asignacion:
	ID ASIGNACION Expresion PUNTO_COMA;

//------------------------
Escritura:
	ESCRITURA PARENTESIS_IZQ Escritura2 PARENTESIS_DER PUNTO_COMA;
Escritura2: 
	Expresion | Expresion COMA Escritura2 | STRING | STRING COMA Escritura2;

//------------------------
Expresion:
	Exp | Exp EXPRESION Exp;

//------------------------
Exp:
	Termino | Termino EXP Termino;

//------------------------
Termino:
	Factor | Factor TERMINO Factor;

//------------------------
Var_cte:
	ID | ENTERO | FLOTANTE;

//------------------------
Condicion:
	IF PARENTESIS_IZQ Expresion PARENTESIS_DER Condicion2
Condicion2: Bloque PUNTO_COMA
			| Bloque ELSE Bloque PUNTO_COMA;

//------------------------
Factor:
	 PARENTESIS_IZQ Expresion PARENTESIS_DER
	 | Var_cte	
	 | EXP Var_cte;

%%

// Desplegar error
int yyerror(char *s){
	printf("El texto %s en la linea %d no es correcto. NO APROPIADO", yytext, yylineno);
	exit(1);
}
// Correr los archivos de prueba
 int main (int argc, char *argv[]){
	yyin = fopen(argv[1], "r");
	yyparse();
	printf("Trabajando correctamente - APROPIADO");
	return 1;
}