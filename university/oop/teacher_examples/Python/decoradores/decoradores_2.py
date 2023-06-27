# !/usr/bin/env python3
# -*- coding: utf-8 -*-
''' 
Un decorador es una función que recibe como parámetro 
una función y que retorna otra función
'''
def suma(a, b):
    return a + b

def funcionalidad_adicional(funcion):
    ''' Decorador sin usar decoradores'''
    def decorador(a, b):
        print("Acá va el código que se adiciona antes")
        print(f'Esta es la función original: {funcion.__name__}')
        print('El resultado después del decorador es: ',funcion(a, b))
        print("Decorador después de llamar a la función")
        
    return decorador

if __name__ == "__main__":
    from subprocess import call
    call('cls',shell=True) # Limpia la pantalla  
    
    funcion_decorada = funcionalidad_adicional(suma) # Nueva funcion_decorada

    funcion_decorada(5, 8)
