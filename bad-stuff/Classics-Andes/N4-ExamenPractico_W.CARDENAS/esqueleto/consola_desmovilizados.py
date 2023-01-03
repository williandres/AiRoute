import desmovilizados as mod
import pandas as pd

def ejecutar_cargar_datos()->pd.DataFrame:
    ruta = input("Ingrese el nombre del archivo con la información de los desmovilizados: ")
    resultados = mod.cargar_datos(ruta)
    print("Datos cargados exitosamente!")
    return resultados

def ejecutar_cantidad_familias_por_numero_hijos(datos: pd.DataFrame) -> None:
    distribucion_familias = mod.cantidad_familias_por_numero_hijos(datos)
    print("La distribución de hijos por familias es: \n", distribucion_familias)

def mostrar_menu()->None:
    print("\nMenú de opciones:")
    print("1. Cargar datos desmovilizados")
    print("2. Calcular la distribucion de hijos por familia")
    print("3. Salir")

def iniciar_aplicacion() -> None:
    datos = None
    continuar = True
    
    while continuar:
        mostrar_menu()
        
        opcion = int(input("Ingrese la opción que desea ejecutar: "))
        if opcion == 1:
            datos = ejecutar_cargar_datos()
        elif opcion == 2:
            ejecutar_cantidad_familias_por_numero_hijos(datos)
        elif opcion == 3:
            continuar = False
        else:
            print("Ingresó una opción no válida, por favor elija una de las opciones del menú")

iniciar_aplicacion()
        
    