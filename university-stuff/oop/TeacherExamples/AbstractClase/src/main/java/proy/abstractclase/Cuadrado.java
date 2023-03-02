package proy.abstractclase;

// Definición de la clase Cuadrado que extiende de Figura
class Cuadrado extends Figura {
  double lado;

  // Constructor de la clase Cuadrado
  Cuadrado(double lado) {
    this.lado = lado;
  }

  // Implementación del método abstracto para calcular el área
  double calcularArea() {
    return lado * lado;
  }
}