
import visor_imagenes as visor_imagenes

def cargar_imagen() -> list:
    """ Muestra las opciones para cargar una imagen y carga la imagen seleccionada por el usuario.
    """
    ruta = input("Ingrese el nombre del archivo que contiene la imagen: ")
    imagen = visor_imagenes.cargar_imagen(ruta)
    visor_imagenes.visualizar_imagen(imagen)
    return imagen

def ejecutar_convertir_negativo(imagen: list) -> list:
    print("Calculando imagen...")
    imagen = visor_imagenes.convertir_negativo(imagen)
    visor_imagenes.visualizar_imagen(imagen)
    return imagen

def ejecutar_reflejar_imagen(imagen: list) -> list:
    print("Calculando imagen...")
    imagen = visor_imagenes.reflejar_imagen(imagen)
    visor_imagenes.visualizar_imagen(imagen)
    return imagen

def ejecutar_binarizar_imagen(imagen: list) -> list:
    print("Calculando imagen...")
    imagen = visor_imagenes.binarizacion_imagen(imagen)
    visor_imagenes.visualizar_imagen(imagen)
    return imagen

def ejecutar_convertir_a_grises(imagen: list) -> list:
    print("Calculando imagen...")
    imagen = visor_imagenes.convertir_a_grises(imagen)
    visor_imagenes.visualizar_imagen(imagen)
    return imagen

def imprimir_menu_principal():
    """ Imprime los items del menú principal de la aplicación
    """
    print("\n          Visor de imágenes\n")
    print("(1) Cargar imagen")
    print("(2) Negativo")
    print("(3) Reflejar")
    print("(4) Binarizacion")
    print("(5) Escala de grises")
    print("(6) Salir")

def ejecutar_aplicacion():
    salir = False

    while(salir==False):
        imprimir_menu_principal()
        opcion = int(input("Ingrese la opción deseada: "))

        if opcion == 1:
            imagen = cargar_imagen()
        elif opcion == 2:
            imagen = ejecutar_convertir_negativo(imagen)
        elif opcion == 3:
            imagen = ejecutar_reflejar_imagen(imagen)
        elif opcion == 4:
            imagen = ejecutar_binarizar_imagen(imagen)
        elif opcion == 5:
            imagen = ejecutar_convertir_a_grises(imagen)
        elif opcion == 6:
            salir = True
        else:
            print("El valor ingresado no es válido.")

ejecutar_aplicacion()