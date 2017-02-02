# -*- coding: utf-8 -*-
# ------------------------------------------------------------
#  José González Ayerdi - A01036121
#  3/02/17
#  Tarea 3, Diseño de Compiladores
#  Sintaxis para el lenguaje MyLittleDuck2017
#  Archivo con expresiones regulares para el análisis lexico con PLY
# ------------------------------------------------------------
import ply.lex as lex

# tupla con los nombres de los tokens
tokens = (
   'ID',
   'IF',
   'ELSE',
   'PROGRAM',
   'ESCRITURA',
   'TIPO',
   'ENTERO',
   'FLOTANTE',
   'EXPRESION',
   'PARENTESIS_IZQ',
   'PARENTESIS_DER',
   'STRING',
   'TERMINO',
   'ASIGNACION',
   'EXP',
   'CORCHETE_IZQ',
   'CORCHETE_DER',
   'COMA',
   'PUNTO_COMA',
   'VAR'
)

# expresiones regulares que definen los tokens
t_ENTERO         = r'[+-]?[0-9]+'
t_FLOTANTE       = r'[+-]?[0-9]+.[0-9]+'
t_EXPRESION      = r'\<|\>|\<>'          
t_PARENTESIS_IZQ = r'\('
t_PARENTESIS_DER = r'\)'
t_STRING         = r'\"(\\.|[^"])*\"'
t_TERMINO        = r'\*|\/'
t_ASIGNACION     = r'\=|\:'
t_EXP            = r'\+|\-'
t_CORCHETE_IZQ   = r'\{'
t_CORCHETE_DER   = '\}'
t_COMA           = r'\,'
t_PUNTO_COMA     = r'\;'

# strings resservados, asi no se confunden con el token ID
reserved = {
   'if'     : 'IF',
   'then'   : 'THEN',
   'else'   : 'ELSE',
   'while'  : 'WHILE',
   'program': 'PROGRAM',
   'print'  : 'ESCRITURA',
   'int'    : 'TIPO',
   'float'  : 'TIPO',
   'var'    : 'VAR'
}

# funcion con la regla para definir la identificacion de un ID
def t_ID(t):
    r'[a-zA-Z](_?[a-zA-Z0-9]+)*'
    t.type = reserved.get(t.value,'ID')
    return t

# funcion para saber el numero de linea que se esta analizando
def t_newline(t):
    r'\n'
    t.lexer.lineno += len(t.value)
    return t

# se ignoran los espacios en blanco
t_ignore  = ' \t\r'

# manejo de errores
def t_error(t):
    print("Caracter desconocido: '%s' en linea:'%s'" % (t.value[0], t.lineno))
    t.lexer.skip(1)
    return t

# construccion del lexer
lexer = lex.lex()

# string para probar el analizador lexico con tokens correctos
data = '''
nombre int if else program print int float 5, 5.4
< > <> () "hola mundo" * / = : + - ,{ } , ; 
'''
# string para probar el analizador lexico con tokens incorrectos
data_err = '''? | .'''

# se corre el lexer con el string de prueba, descomentar para probar
#lexer.input(data)

# se generan los tokens y se verifica que sean validos
'''
while True:
    tok = lexer.token()
    if not tok: 
        break
    #print(tok)  # se imprime el tipo de token que se encontro
'''