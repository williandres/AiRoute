import random
numero=0
def busqueda_binaria(lista, comienzo, final, objetivo):
    print(f'buscando {objetivo} entre {lista[comienzo]} y {lista[final - 1]} [{comienzo}:{final}]')
    global numero
    numero+=1
    if comienzo > final:
        return (False,numero)
    medio = (comienzo + final) // 2 #division entera

    if lista[medio] == objetivo:
        return (True,numero)
    elif lista[medio] < objetivo:
        return busqueda_binaria(lista, medio + 1, final, objetivo)
    else:
        return busqueda_binaria(lista, comienzo, medio - 1, objetivo)


def busqueda_lineal(lista, objetivo):
    match = False
    numero=0

    for elemento in lista: # O(n)
        numero+=1
        if elemento == objetivo:
            match = True
            break

    return (match,numero)

if __name__ == '__main__':
    tamano_de_lista = int(input('De que tamano es la lista? '))
    objetivo = int(input('Que numero quieres encontrar? '))
    lista = sorted([random.randint(0, 100) for i in range(tamano_de_lista)])
    print(lista)
    encontrado1 = busqueda_binaria(lista, 0, len(lista), objetivo)
    encontrado2 = busqueda_lineal(lista, objetivo)
    print(f'El elemento {objetivo} {"esta" if encontrado1[0] and encontrado2[0] else "no esta"} en la lista')
    print(f"Busqeda Binaria, Numero de iteraciones: {encontrado1[1]}")
    print(f"Busuqeda Lineal, Numero de iteraciones: {encontrado2[1]}")