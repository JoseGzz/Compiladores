/*
	Jose Gonzalez Ayerdi - A01036121
	3/02/17
	Tarea 3, Disenio de Compiladores
	Léxico para el lenguaje MyLittleDuck2017
	Expresiones regulares para el análisis léxico con Flex
*/

%{
//#include "archivos_prueba/valores.h" // archivo para prbar el analizador lexico
#include "parser.tab.c" // es necesario comentar esta linea para probar
%}
%option yylineno

%%

\if                             {return IF;}
\else                           {return ELSE;}
\program                        {return PROGRAM;}
\print                          {return ESCRITURA;}
"var"                           {return VAR;}
\int|float                      {return TIPO;}
[a-zA-Z](_?[a-zA-Z0-9]+)*       {return ID;}
[+-]?[0-9]+                     {return ENTERO;}
[+-]?[0-9]+.[0-9]+              {return FLOTANTE;}
[ \n\t\r]+                      {;} // se ignoran los espacios en blanco
\<|\>|\<>                       {return EXPRESION;}
\(                              {return PARENTESIS_IZQ;}
\)                              {return PARENTESIS_DER;}
\"(\\.|[^"])*\"                 {return STRING;}
"*"|"/"                         {return TERMINO;}
\=|\:                           {return ASIGNACION;}
\+|\-                           {return EXP;}
\{                              {return CORCHETE_IZQ;}
\}                              {return CORCHETE_DER;}
\,                              {return COMA;}
\;                              {return PUNTO_COMA;}
.                               {return yyerror(yytext);}
%%

int yywrap(void) {
	return 1;
}
