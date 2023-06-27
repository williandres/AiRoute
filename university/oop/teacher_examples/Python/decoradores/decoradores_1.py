# !/usr/bin/env python
# -*- coding: utf-8 -*-

''' Decoradores forma corta '''

def mi_decorador(funcion):
   ''' Se controla lo que se retorna '''
   def funcionalidad_adicional(*args):
      print('1.Va a ejecutar la función anterior a la que se decora')
      print(f'2. Voy a ejecutar la función: {funcion.__name__}')
      print(funcion(*args)) # esta función equivale a la función que se ejecuta
      # resultado = funcion(*args) # esta función equivale a la función que se ejecuta
      print('3. Ya se ejecutó la función y estoy en la función del decorador')
         
   return funcionalidad_adicional


@ mi_decorador
def unir_cadena(cadena1, cadena2, cadena_3):
   return 'Así quedó la unión de cadenas: ' + cadena1 + ' ' + cadena2 + ' ' + cadena_3
    

@mi_decorador
def potencia(base, exponente):
   return f'El resultado de {base} a la potencia: {exponente} es: ' + str(pow(base,exponente))
   
    
if __name__ == "__main__":
   cadena_1 = "Estamos usando"
   cadena_2 = "Decoradores"
   cadena_3 = 'Aún más'
   
   print('='*50)
   print('Cadena 1: ',cadena_1)
   print('Cadena 2: ',cadena_2)
   print('Cedena 3: ',cadena_3)
   unir_cadena(cadena_1,cadena_2,cadena_3)
   # print(unir_cadena(cadena_1,cadena_2,cadena_3))

   print('='*50)

   base = 8
   exponente = 4
   potencia(base,exponente)
   # print(f'El resultado de {base} a la potencia: {exponente} es:',potencia(base,exponente))
   print()
