%{
#include "valores.h"
%}

%%
\if|else					return CONDICION;
"program"					return PROGRAM;
"print"						return ESCRITURA;
\int|float					return TIPO;
[+|-]?[0-9]+				return ENTERO;
[a-zA-Z](_?[a-zA-Z0-9]+)*	return ID;
[-]?[0-9]+.[0-9]+			return FLOTANTE;
[ \n\t\r]+					return ESPACIO;
\<|\>						return EXPRESION;
\(|\)						return PARENTESIS;
\"(\\.|[^"])*\"				return STRING;
\*|\/						return TERMINO;
\=|\:						return ASIGNACION;
\+|-						return EXP;
\{|\}						return CORCHETE;
\;							return PUNTO_COMA;
%%

int yywrap(void) {
	return 1;
}