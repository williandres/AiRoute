# !/usr/bin/env python3
# -*- coding: utf-8 -*-
from subprocess import call

# def sumar(a,b):
#    return a + b
   
# if __name__ == "__main__":
#     call('cls',shell=True) # Limpia la pantalla  

#     print(sumar(2,1))
#     var_funcion = sumar

#     print(var_funcion(5,20)) # ejecuta la función sumar e imprime 25
 
''' Forma simple de decorar ''' 

def sumar(a,b):
   return a + b

def mi_ejecutar(funcion,a,b):
   print('Antes de realizar la operación')
   print(funcion(a,b)) 
   print('Después de ejecutar la función')

if __name__ == "__main__":
    call('cls',shell=True) # Limpia la pantalla  
    var_funcion = sumar 
    mi_ejecutar(var_funcion,5,20) # ejecuta la función sumar e imprime 25
 
 
''' Decorador usando @'''
# def funcion_a(funcion_b):

#     def funcion_c():
#         print('Haciendo algo antes de llamar a funcion_b()')

#         funcion_b()

#         print('Haciendo algo después de llamar a funcion_b()')

#     return funcion_c

# @funcion_a
# def funcion_a_decorar():
#     print(' . . . Soy la función a decorar . . .')


# if __name__ == "__main__":
#     call('cls',shell=True) # Limpia la pantalla
#     funcion_a_decorar()
    