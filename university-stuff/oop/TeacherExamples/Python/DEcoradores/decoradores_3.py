# !/usr/bin/env python3
# -*- coding: utf-8 -*-
from subprocess import call

''' Anidamiento de funciones y decoradora recibiendo parámetros '''

def log(archivo_log):
    def decorador_log(func):
        def decorador_funcion(*args, **kwargs):
            with open(archivo_log, 'a') as file:
                output = func(*args, **kwargs)
                file.write(f"{output}\n")
        return decorador_funcion
    return decorador_log

@log('archivo_salida.log')
def suma(a, b):
    return a + b

@log('archivo_salida.log')
def resta(a, b):
    return a - b

@log('archivo_salida.log')
def multiplicadivide(a, b, c):
    if c!= 0: return a*b/c
    else: return 'Error el dividendo no puede ser 0'

@log('archivo_salida.log')
def fin(txt):
    return txt.upper()

@log('archivo_salida.log')
def con_diccionario(diccionario):
    return diccionario.items() 

if __name__ == "__main__":
    call('cls',shell=True) # Limpia la pantalla  
    suma(5000,2530)
    resta(7100, 2050)
    multiplicadivide(15, 10, 5)
    con_diccionario({'Colombia':'Bogotá','Perú':'Lima'})
    fin('=== Final del archivo ===')
