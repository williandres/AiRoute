package proy.abstractclase;

// Definición de la clase Circulo que extiende de Figura
class Circulo extends Figura {
  double radio;

  // Constructor de la clase Circulo
  Circulo(double radio) {
    this.radio = radio;
  }

  // Implementación del método abstracto para calcular el área
  double calcularArea() {
    return Math.PI * radio * radio;
  }
}