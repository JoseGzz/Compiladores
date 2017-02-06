/*
	Jose Gonzalez Ayerdi - A01036121
	3/02/17
	Tarea 3, Diseño de Compiladores
	Sintaxis para el lenguaje MyLittleDuck2017
	Gramatica regular para el análisis sintactico con Bison
*/

%{
	#include <stdio.h>	   // funciones estandar (printf, etc.)
	extern FILE *yyin;     // variable para leer un archivo
	extern char *yytext;   // texto que se esta analizando
	extern int   yylex();  // estructura para acceder a la tabla de tokens
	extern int   yylineno; // linea que se esta analizando 
%}

/*
	Se establece la lista de tokens
	que se usara en el analisis gramatical.
*/
%token IF
%token ELSE
%token PROGRAM
%token ESCRITURA
%token TIPO
%token ID
%token ENTERO 
%token FLOTANTE
%token EXPRESION
%token PARENTESIS_IZQ
%token PARENTESIS_DER
%token STRING 
%token TERMINO
%token ASIGNACION
%token EXP
%token CORCHETE_IZQ
%token CORCHETE_DER
%token SEPARATOR
%token COMA
%token PUNTO_COMA
%token VAR

%start program
%%

program:
	PROGRAM ID PUNTO_COMA vars bloque
	| PROGRAM ID PUNTO_COMA bloque;

//------------------------
vars:
	VAR vars2;
vars2:
	ID vars3;
vars3:
	COMA vars2
	| ASIGNACION TIPO PUNTO_COMA vars2
	| ASIGNACION TIPO PUNTO_COMA;

//------------------------
bloque:
	CORCHETE_IZQ bloque2 CORCHETE_DER;
bloque2:
	estatuto | estatuto bloque2;

//------------------------
estatuto:
	asignacion | condicion | escritura;

//------------------------
asignacion:
	ID ASIGNACION expresion PUNTO_COMA;

//------------------------
escritura:
	ESCRITURA PARENTESIS_IZQ escritura2 PARENTESIS_DER PUNTO_COMA;
escritura2: 
	expresion | expresion COMA escritura2 | STRING | STRING COMA escritura2;

//------------------------
expresion:
	exp | exp EXPRESION exp;

//------------------------
exp:
	termino | termino EXP termino;

//------------------------
termino:
	factor | factor TERMINO factor;

//------------------------
var_cte:
	ID | ENTERO | FLOTANTE;

//------------------------
condicion:
	IF PARENTESIS_IZQ expresion PARENTESIS_DER condicion2
condicion2: bloque PUNTO_COMA
			| bloque ELSE bloque PUNTO_COMA;

//------------------------
factor:
	 PARENTESIS_IZQ expresion PARENTESIS_DER
	 | var_cte	
	 | EXP var_cte;

%%

/*
	yyerror
	Despliega un mensaje de error en caso de que se encuentre
	alguna irregularidad en el scanner o en el parser.
*/
int yyerror(char *s) {
	if(strcmp("syntax error", s) != 0) {
		fprintf(stderr, "Error léxico en línea %d: %s.\n", yylineno, s);
	} else {
		fprintf(stderr, "Error de sintaxis en línea %d.\n", yylineno);
	}
	exit(1);
}
/*
	main
	Funcion principal que lee un archivo de entrada y lo analiza.
	Si todo funciona correctamente se despliega un mensaje de finalizacion.
*/
int main (int argc, char *argv[]) {
	yyin = fopen(argv[1], "r");
	yyparse();
	printf("Finalizó sin errores.\n");
	return 0;
}
