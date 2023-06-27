def suma_de_primos(n: int)->int:
    resultado=0
    for j in range(2,n):
            resultado+=esPrimo(j)
    return resultado

def esPrimo(j: int)->int:
    for i in range(2,j):
        if j%i==0:
            return 0
    return j

if __name__=='__main__':
    suma_de_primos(12)