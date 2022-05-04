import sys
sys.setrecursionlimit(1000000)
#¿Que algoritmo es más eficiente?
import time
#Codigo Iterativo:
def factorial(n):
    respuesta = 1
    while n > 1:
        respuesta *= n
        n -= 1

    return respuesta

#Codigo Recursivo:
def factorial_r(n):
    if n == 1:
        return 1

    return n * factorial_r(n - 1)


if __name__ == '__main__':
    n = 200000

    comienzo = time.time()
    factorial(n)
    final = time.time()
    print("LOOP: "+ str(final - comienzo))

    comienzo = time.time()
    factorial_r(n)
    final = time.time()
    print("RECURSIVIDAD: " +str(final - comienzo))