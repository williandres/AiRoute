package proy.interfaces;

public class Cuadrado implements Figura {
  double lado;

  // Constructor de la clase Cuadrado
  public Cuadrado(double lado) {
    this.lado = lado;
  }

  // Implementación del método calcularArea() de la interfaz Figura
  public double calcularArea() {
    return lado * lado;
  }

  // Implementación del método calcularPerimetro() de la interfaz Figura
  public double calcularPerimetro() {
    return 4 * lado;
  }
}
