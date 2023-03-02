package proy.interfaces;


// Definición de la clase Triángulo que implementa la interfaz Figura
public class Triangulo implements Figura {
  double base;
  double altura;
  double lado1;
  double lado2;
  double lado3;

  // Constructor de la clase Triángulo
  public Triangulo(double base, double altura, double lado1, double lado2, double lado3) {
    this.base = base;
    this.altura = altura;
    this.lado1 = lado1;
    this.lado2 = lado2;
    this.lado3 = lado3;
  }

  // Implementación del método calcularArea() de la interfaz Figura
  @Override
  public double calcularArea() {
    return (base * altura) / 2;
  }

  // Implementación del método calcularPerimetro() de la interfaz Figura
  @Override
  public double calcularPerimetro() {
    return lado1 + lado2 + lado3;
  }
}
