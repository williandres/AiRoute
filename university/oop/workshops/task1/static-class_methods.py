""""
@Willian Cárdenas

En este código, se ha creado una clase llamada CamionCarga para representar un camión de carga. 
La clase tiene atributos privados (nombre, referencia y peso), 
que se han encapsulado usando el doble guión bajo (__) para evitar que se accedan desde fuera de la 
clase. También se ha creado un atributo de clase privado (__carga) para hacer un seguimiento de la 
carga total del camión.

Se han creado tres métodos para acceder a los atributos privados usando el decorador @property. 
Estos métodos son _get_peso, _get_nombre e informacion, y se han utilizado para mostrar información 
sobre los objetos creados.

El decorador @staticmethod se utiliza para definir métodos que no requieren el acceso a 
atributos de instancia o de clase y no necesitan crear una instancia de la clase. 
Estos métodos se pueden llamar en cualquier lugar del código y no están vinculados 
a ninguna instancia particular. En este caso, el método _conversor_kilos_a_libras 
es un método estático que se utiliza para convertir la carga de kilos a libras.

El decorador @classmethod se utiliza para definir métodos que operan en la clase misma 
en lugar de en una instancia de la clase. Estos métodos tienen acceso a los atributos 
de clase y se utilizan comúnmente para definir constructores alternativos para la clase. 
En este caso, el método get_carga_total es un método de clase que se utiliza para acceder 
al atributo __carga de la clase CamionCarga.
"""

class CamionCarga:
    __carga = 7  # Carga en kilos

    def __init__(self, nombre, referencia, peso):
        self.__nombre = nombre  # Encapsulamiento de los atributos de instancia usando "__"
        self.__referencia = referencia
        self.__peso = peso
        CamionCarga.__carga += peso

    @staticmethod
    def _conversor_kilos_a_libras(k):
        """Método estático que convierte kilogramos a libras"""
        return round(k * 2.20462, 2)

    @property
    def informacion(self):
        """Método que devuelve información sobre el objeto, usando @property para acceder a los atributos privados"""
        return f"Nombre: {self.__nombre}\nReferencia: {self.__referencia}\nPeso: {self.__peso} kilos"

    @property
    def _get_peso(self):
        """Método que devuelve el peso del objeto, usando @property para acceder al atributo privado"""
        return self.__peso

    @property
    def _get_nombre(self):
        """Método que devuelve el nombre del objeto, usando @property para acceder al atributo privado"""
        return self.__nombre

    @classmethod
    def get_carga_total(cls):
        """Método de clase que devuelve la carga total, usando @classmethod para acceder al atributo de clase privado"""
        return cls.__carga


if __name__ == '__main__':
    print("CAMIONES S.A \n")
    o1 = CamionCarga("Willian", 'Humano', 65)
    o2 = CamionCarga("Konate", 'Humano', 95)
    o3 = CamionCarga("Violin", 'Instrumento', 1)
    print("Objetos en la carga \n")
    print(o1.informacion)
    print("-")
    print(o2.informacion)
    print("-")
    print(o3.informacion)
    print("---" * 5)
    print('Carga total: ', CamionCarga.get_carga_total(), end=" kilos \n")
    print('Carga total en libras: ', CamionCarga._conversor_kilos_a_libras(CamionCarga.get_carga_total()),
    end=" libras \n")
    print(f"Carga de '{o2._get_nombre}' en libras: ", CamionCarga._conversor_kilos_a_libras(o2._get_peso),
    end=" libras \n")