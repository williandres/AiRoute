"""
Ejercicio nivel 3: Blockchain de Cupicoin.
Interfaz basada en consola para la interaccion con el usuario.

Temas:
* Instrucciones repetitivas.
* Listas
* Diccionarios
* Archivos
@author: Cupi2
"""
#WILLIAN ANDRES CARDENAS SANDOVAL

import cupicoin as cc
import time as t

def ejecutar_cargar_blockchain_cupicoin() -> list:
    """Solicita al usuario que ingrese el nombre de un archivo CSV con los datos de las transacciones.
    Retorno: dict
        El diccionario de bloques con la informacion del archivo.
    """
    bloques = None
    archivo = input("Por favor ingrese el nombre del archivo CSV con las transacciones: ")
    bloques = cc.cargar_blockchain_cupicoin(archivo)
    if len(bloques) == 0:
        print("El archivo seleccionado no es valido. No se pudieron cargar los bloques.")
    else:
        print("Se cargaron los siguientes bloques con su correspondiente hash a partir del archivo.")
        for transaccion in bloques:
            print(transaccion["Hash"])
    return bloques

def ejecutar_agregar_transaccion(blockchain:list) -> None:
    """Ejecuta la opción de agregar una transacción al último bloque del blockchain de Cupicoin.
    """
    codigo = input("Ingrese el código de la transacción: ")
    remitente = input("Ingrese la dirección de la cuenta que envía la transacción: ")
    operacion = input("Ingrese el tipo de operación (transferencia/contrato): ")
    destinatario = ""
    if operacion == "transferencia":
        destinatario = input("Ingrese la dirección de la cuenta que recibe la transacción: ")
    valor = float(input("Ingrese el valor a transferir en la transacción: "))
    cc.añadir_trans(blockchain,codigo,remitente,operacion,destinatario,valor) 

def ejecutar_agregar_nuevo_bloque(blockchain:list) -> None:
    """Ejecuta la opción de agregar un nuevo bloque al final del blockchain de Cupicoin.'
    """
    timestamp = int(t.time())
    cc.final_bloque(blockchain, timestamp)

def ejecutar_contar_veces_aparece_cuenta(blockchain:list) -> None:
    """Ejecuta la opción que cuenta el número de transacciones en los que una cuenta ingresada
    por parámetro ha sido registrada como remitente o como destinataria en una transacción.
    El mensaje que se le muestra al usuario debe tener el siguiente formato:'El número de transacciones
    que contienen a la cuenta (id_cuenta) es: (conteo_remitente) como remitente y (conteo_destinatario)
    como destinatario'
    """
    id_cuenta = input("Ingrese la dirección de la cuenta a buscar: ")
    dicc=cc.numero_veces(blockchain,id_cuenta)
    remitente=str(dicc["Remitente"])
    destinatario=str(dicc["Destinatario"])
    print("El número de transacciones que contienen a la cuenta " +id_cuenta+ " es: "+remitente+ " como remitente y " +destinatario+" como destinatario")

def ejecutar_buscar_transaccion(blockchain:list) -> None:
    """Ejecuta la opción que consulta la información de una transacción dado su código.
    El mensaje que se le muestra al usuario debe tener el siguiente formato:
    'La transacción con el código (codigo_tr) es: (diccionario_transaccion)'
    En caso de que no exista una transacción que coincida con el código suministrado,
    se debe informar al usuario con el mensaje:
    'La transacción con el código (codigo_tr) no ha sido encontrada'
    """
    codigo_tr = input("Ingrese el código de la transacción a consultar: ")
    res=cc.dicc_transaccion(blockchain,codigo_tr)
    
    if res==None:
        print("La transacción con el código "+codigo_tr+" no ha sido encontrada" )
    else:
        print("La transacción con el código "+codigo_tr+ " es: ", res)

def ejecutar_validar_bloque(blockchain:list) -> None:
    """Ejecuta la opción que valida la integridad del blockchain. Si el bloque no tiene ningún problema
    de integridad, se debe mostrar el mensaje "El blockchain no tiene ningún problema". De lo contrario
    si se encuentra alguna irregularidad dentro del blockchain, se debe mostrar el mensaje "Se encontró
    una irregularidad dentro del blockchain"..
    """
    val=cc.validar_blockchain(blockchain)
    
    if val==True:
        print("El blockchain no tiene ningún problema")
    elif val==False:
        print("Se encontró una irregularidad dentro del blockchain")

def ejecutar_dar_transacciones_entre(blockchain:list) -> None:
    """Ejecuta la opción que encuentra las transacciones que tienen un remitente y destinatario
    específicos dadas sus direcciones de cuenta. El mensaje que se le muestra al usuario debe
    tener el siguiente formato: 'Las transacciones con el remitente (remitente) y el destinatario
    (destinatario) son: (lista_de_transacciones).' En caso de no haber ninguna transacción con
    las direcciones especificadas, se debe informar al usuario con el siguiente mensaje: 
    'No existen transacciones con el remitente (remitente) y el destinatario (destinatario)'
    """
    remitente = input("Ingrese la dirección de cuenta del remitente: ")
    destinatario = input("Ingrese la dirección de cuenta del destinatario: ")
    res=cc.transacciones_rem_dest(blockchain,remitente,destinatario)
    if res==[]:
        print("No existen transacciones con el remitente "+remitente+" y el destinatario "+destinatario)
    else:
        print("Las transacciones con el remitente "+remitente+ " y el destinatario " +destinatario+ " son: ", res)


def ejecutar_dar_transferencia_mayor_valor(blockchain:list) -> None:
    """Ejecuta la opción que encuentra la transacción con el valor máximo.
    El mensaje que se le muestra al usuario debe tener el siguiente formato:
    'La transacción con mayor valor en el blockchain de Cupicoin es: 
    (diccionario_transaccion)'
    """
    dicc=cc.transaccion_mayorvalor(blockchain)
    print("La transacción con mayor valor en el blockchain de Cupicoin es: ",dicc)

def ejecutar_calcular_saldo_cuenta(blockchain:list) -> None:
    """Ejecuta la opción que calcula el saldo de una cuenta.
    El mensaje que se le muestra al usuario debe tener el siguiente formato:
    'El saldo de la cuenta (id_cuenta) es de (saldo) Cupicoins'.
    Puede asumir que el identificador de cuenta ingresado por el usuario existe.
    """
    id_cuenta = input("Ingrese la dirección de la cuenta que desea buscar su saldo: ")
    res=cc.saldocuenta(blockchain,id_cuenta)
    print("El saldo de la cuenta "+id_cuenta+" es de ",res," Cupicoins")
    
def mostrar_menu():
    """Imprime las opciones de ejecución disponibles para el usuario.
    """
    print("\nOpciones")
    print("1. Cargar un archivo de transacciones.")
    print("2. Añadir una nueva transacción.")
    print("3. Añadir un nuevo bloque.")
    print("4. Consultar número de transacciones con cuenta remitente o destinataria específica.")
    print("5. Consultar información de una transacción.")
    print("6. Validar bloque.")
    print("7. Encontrar transacciones con remitente y destinatario específicos.")
    print("8. Consultar transacción con el valor máximo. ")
    print("9. Calcular el saldo de una cuenta.")
    print("10. Salir.")

def iniciar_aplicacion():
    """Ejecuta el programa para el usuario."""
    continuar = True
    blockchain = []
    while continuar:
        mostrar_menu()
        opcion_seleccionada = int(input("Por favor seleccione una opción: "))
        if opcion_seleccionada == 1:
            blockchain = ejecutar_cargar_blockchain_cupicoin()
        elif opcion_seleccionada ==2:
            ejecutar_agregar_transaccion(blockchain)
        elif opcion_seleccionada ==3:
            ejecutar_agregar_nuevo_bloque(blockchain)
        elif opcion_seleccionada ==4:
            ejecutar_contar_veces_aparece_cuenta(blockchain)
        elif opcion_seleccionada ==5:
            ejecutar_buscar_transaccion(blockchain)
        elif opcion_seleccionada ==6:
            ejecutar_validar_bloque(blockchain)
        elif opcion_seleccionada ==7:
            ejecutar_dar_transacciones_entre(blockchain)
        elif opcion_seleccionada ==8:
            ejecutar_dar_transferencia_mayor_valor(blockchain)
        elif opcion_seleccionada ==9:
            ejecutar_calcular_saldo_cuenta(blockchain)
        elif opcion_seleccionada == 10:
            continuar = False
        else:
            print("Por favor seleccione una opción válida.")

#PROGRAMA PRINCIPAL
iniciar_aplicacion()