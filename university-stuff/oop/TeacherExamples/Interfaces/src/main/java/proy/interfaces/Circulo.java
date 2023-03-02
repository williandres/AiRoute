package proy.interfaces;

// Definición de la clase Círculo que implementa la interfaz Figura
public class Circulo implements Figura {
  double radio;

  // Constructor de la clase Círculo
  public Circulo(double radio) {
    this.radio = radio;
  }

  // Implementación del método calcularArea() de la interfaz Figura
  public double calcularArea() {
    return Math.PI * radio * radio;
  }

  // Implementación del método calcularPerimetro() de la interfaz Figura
  public double calcularPerimetro() {
    return 2 * Math.PI * radio;
  }
}
