package proy.abstractclase;

// Definición de la clase abstracta Figura
abstract class Figura {
  // Método abstracto para calcular el área de la figura
  abstract double calcularArea();

  // Método concreto para imprimir la información de la figura
  void imprimirInformacion() {
    System.out.println("clase Figura usando el metodo imprimirInformacion()");
  }
}
