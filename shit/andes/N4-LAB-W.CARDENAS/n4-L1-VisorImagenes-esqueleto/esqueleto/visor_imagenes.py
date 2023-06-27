
import matplotlib.image as mpimg
import matplotlib.pyplot as plt


def cargar_imagen(ruta_imagen: str)-> list:
    """ Carga la imagen que se encuentra en la ruta dada.
    Parámetros:
        ruta_imagen (str) Ruta donde se encuentra la imagen a cargar.
    Retorno:
        list: Matriz de MxN con tuplas (R,G,B).
    """
    matriz = mpimg.imread(ruta_imagen).tolist()
    alto = len(matriz)
    ancho = len(matriz[0])
    imagen = []
    for i in range(alto):
        fila = []
        for j in range(ancho):
            r = matriz[i][j][0]
            g = matriz[i][j][1]
            b = matriz[i][j][2]
            tupla = (r, g, b)
            fila.append(tupla)
        imagen.append(fila)
    return imagen


def visualizar_imagen(imagen: list) -> None:
    """ Muestra la imagen recibida
    Parámetros:
        imagen (list): Matriz de MxN con tuplas (R,G,B) que representan la imagen a visualizar.
    """
    alto = len(imagen)
    ancho = len(imagen[0])
    matriz = []
    for i in range(alto):
        fila = []
        for j in range(ancho):
            r, g, b = imagen[i][j]
            fila.append([r, g, b])
        matriz.append(fila)
    plt.imshow(matriz)
    plt.show()


def convertir_negativo(imagen: list) -> list:
    """  Convierte la imagen en negativo.
    El negativo se calcula cambiando cada componente RGB, tomando el valor absoluto de restarle al componente 1.0.
    Parámetros:
        imagen (list) Matriz de MxN con tuplas (R,G,B) que representan la imagen a convertir a negativo.
    """
    alto = len(imagen)
    ancho = len(imagen[0])

    for i in range(alto):
        for j in range(ancho):
            r, g, b = imagen[i][j]
            nuevo = (abs(r-1), abs(g-1), abs(b-1))
            imagen[i][j] = nuevo
    return imagen


def reflejar_imagen(imagen: list)->list:
    """Refleja la imagen.
    Consiste en intercambiar las columnas enteras de la imagen, de las finales a la iniciales.
    Parámetros:
        imagen (list) Matriz de MxN con tuplas (R,G,B) que representan la imagen a reflejar.
    """
    imagen_final=[]
    alto = len(imagen)#columna
    ancho = len(imagen[0])#fila

    for i in range(alto):
        fila=[]
        for j in range(ancho):
            pos=(len(imagen[i])-1)-j
            nuevo=imagen[i][pos]
            fila.append(nuevo)
        imagen_final.append(fila)
    return imagen_final

def binarizacion_imagen(imagen: list)->list:
    """ 
    Parámetros:
        imagen (list) Matriz de MxN con tuplas (R,G,B) que representan la imagen a convertir a grises.
    """
    alto = len(imagen)
    ancho = len(imagen[0])
    rojo=0.0
    verde=0.0
    azul=0.0
    m=0
    for i in range(alto):
        for j in range(ancho):
            r, g, b = imagen[i][j]
            rojo=rojo+abs(r)
            verde=verde+abs(g)
            azul=azul+abs(b)
            m=m+1
    umbral=((rojo/m)+(verde/m)+(azul/m))/3
    print(umbral)
    for i in range(alto):
        for j in range(ancho):
            r, g, b = imagen[i][j]
            prom=(abs(r)+abs(g)+abs(b))/3
            if prom>=umbral:
                nuevo = (1.0, 1.0, 1.0)
            if prom<umbral:
                nuevo = (0.0, 0.0, 0.0)
            imagen[i][j] =nuevo
    return imagen

def convertir_a_grises(imagen: list)->list:
    """ Convierte la imagen a escala de grises.
    Para ello promedia los componentes de cada pixel y crea un nuevo color donde cada componente (RGB) tiene el valor de dicho promedio.
    Parámetros:
        imagen (list) Matriz de MxN con tuplas (R,G,B) que representan la imagen a convertir a grises.
    """
    alto = len(imagen)
    ancho = len(imagen[0])
    for i in range(alto):
        for j in range(ancho):
            r, g, b = imagen[i][j]
            prom=(abs(r)+abs(g)+abs(b))/3
            nuevo = (prom, prom, prom)
            imagen[i][j] = nuevo
    return imagen