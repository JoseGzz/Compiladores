/*
	Jose Gonzalez Ayerdi - A01036121
	Tarea 3
	Lexico para el lenguaje MyLittleDuck2017
*/


%{
//#include "valores.h" // archivo para prbar el analizador lexico
#include "parser.tab.c"
%}
%option yylineno

%%

\if								return IF;
\else							return ELSE;
\program						return PROGRAM;
\print							return ESCRITURA;
"var" 							return VAR;
\int|float	 					return TIPO;
[a-zA-Z](_?[a-zA-Z0-9]+)*		return ID;
[+-]?[0-9]+						return ENTERO;
[+-]?[0-9]+.[0-9]+				return FLOTANTE;
[ \n\t\r]+						; // se ignoran los espacios en blanco
\<|\>|\<>						return EXPRESION;
\(								return PARENTESIS_IZQ;
\)								return PARENTESIS_DER;
\"(\\.|[^"])*\" 				return STRING;
"*"|"/"							return TERMINO;
\=|\:							return ASIGNACION;
\+|\-							return EXP;
\{								return CORCHETE_IZQ;
\}								return CORCHETE_DER;
\,								return COMA;
\;								return PUNTO_COMA;

%%
s
int yywrap(void) {
	return 1;
} 