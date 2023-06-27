package proy.abstractclase;

public class AbstractClase {

  public static void main(String[] args) {
    // Creación de objetos de tipo Cuadrado y Circulo
    Cuadrado cuadrado = new Cuadrado(5);
    Circulo circulo = new Circulo(3);

    // Llamada al método imprimirInformacion() de cada objeto
    cuadrado.imprimirInformacion();
    circulo.imprimirInformacion();

    // Llamada al método calcularArea() de cada objeto
    System.out.println("El área del cuadrado es: " + cuadrado.calcularArea());
    System.out.println("El área del círculo es: " + circulo.calcularArea());
  }
}