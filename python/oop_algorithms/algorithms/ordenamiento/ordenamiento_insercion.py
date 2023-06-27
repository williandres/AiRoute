def ordenamiento_por_insercion(lista):

    for indice in range(1, len(lista)):
        valor_actual = lista[indice]
        posicion_actual = indice

        while posicion_actual > 0 and lista[posicion_actual - 1] > valor_actual:
            lista[posicion_actual] = lista[posicion_actual - 1]
            posicion_actual -= 1

        lista[posicion_actual] = valor_actual
        print(f'Proceso... {lista}')
    return lista
if __name__=='__main__':
    lista=[3,2,7,9,1,5,8,6,4]
    print(f'Lista desordenada: {lista}')
    print(f'Lista ordenada: {ordenamiento_por_insercion(lista)}')