/*
	Codigo que imprime el id de cada token.
	Se hace con el proposito de probar el funcionamiento
	del scanner.
*/
#include <stdio.h>

extern int yylex();
extern int yylineno;
extern char* yytext;

int main(void) {
	int ntoken, vtoken;

	ntoken = yylex();
	while(ntoken) {
		printf("%d\n", ntoken);
		ntoken = yylex();	
	}
	return 0;
}