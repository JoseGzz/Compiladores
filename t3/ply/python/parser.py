#!/usr/bin/env python
# -*- coding: utf-8 -*-
#------------------------------------------------------------
#
#  Jose Gonzalez Ayerdi - A01036121
#  3/02/17
#  Tarea 3, Diseño de Compiladores
#  Sintaxis para el lenguaje MyLittleDuck2017
#  Gramatica regular para el análisis sintactico con PLY
#------------------------------------------------------------

import ply.yacc as yacc
import sys
# obtenemos la lista de tokens generadas por el analizador lexico
from scanner import tokens

''' a continuacion de definen las reglas para determinar la gramatica '''

def p_program(p):
  '''
    program : PROGRAM ID PUNTO_COMA vars bloque
  | PROGRAM ID PUNTO_COMA bloque
  '''

def p_vars(p):
  'vars : VAR vars2'
def p_vars2(p):
  'vars2 : ID vars3'
def p_vars3(p):
  '''vars3 : COMA vars2
        | ASIGNACION TIPO PUNTO_COMA vars2
        | ASIGNACION TIPO PUNTO_COMA
  '''

def p_bloque(p):
  'bloque : CORCHETE_IZQ bloque2 CORCHETE_DER'
def p_bloque2(p):
  '''bloque2 : estatuto
  | estatuto bloque2'''

def p_estatuto(p):
  '''estatuto : asignacion
  | condicion
  | escritura'''

def p_asignacion(p):
  'asignacion : ID ASIGNACION expresion PUNTO_COMA'

def p_escritura(p):
  'escritura : ESCRITURA PARENTESIS_IZQ escritura2 PARENTESIS_DER PUNTO_COMA'
def p_escritra2(p):
  '''
  escritura2 :  expresion
  | expresion COMA escritura2
  | STRING
  | STRING COMA escritura2
  '''

def p_expresion(p):
  '''expresion : exp
  | exp EXPRESION exp
  '''

def p_exp(p):
  '''exp : termino
  | termino EXP termino
  '''

def p_termino(p):
  '''termino : factor
  | factor TERMINO factor'''

def p_var_cte(p):
  '''var_cte : ID
  | ENTERO
  | FLOTANTE
  '''

def p_condicion(p):
  'condicion : IF PARENTESIS_IZQ expresion PARENTESIS_DER condicion2'
def p_condicion2(p):
  '''
  condicion2 : bloque PUNTO_COMA
             | bloque ELSE bloque PUNTO_COMA
  '''
def p_factor(p):
  '''
  factor : PARENTESIS_IZQ expresion PARENTESIS_DER
   | var_cte  
   | EXP var_cte
  '''

# funcion para manejar errores
def p_error(p):
  print("Error de sintaxis!")

# se contruye el parser
parser = yacc.yacc()

# lista para guardar la lineas de la entrada
lines = []

# se lee linea por linea el contenido de un archivo
# especificado como argumento al momento de correr el programa
for line in sys.stdin:
  stripped = line.strip()
  if not stripped: break
  lines.append(stripped)
# se crea un solo string con los strings en la lista
input = ' '.join(lines)
# se parsea la entrada
#print input
result = parser.parse(input)

#if result is None:
  #print result#'Sintaxis correcta.'
