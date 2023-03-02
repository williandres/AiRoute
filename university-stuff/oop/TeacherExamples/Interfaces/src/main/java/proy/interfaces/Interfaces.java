package proy.interfaces;

public class Interfaces {
    // Clase principal que utiliza las clases Cuadrado, Circulo y Triangulo
    public static void main(String[] args) {
        System.out.println("Ejemplo de Interfaces");
        Cuadrado cuadrado = new Cuadrado(2);
        Circulo circulo = new Circulo(3);
        Triangulo triangulo = new Triangulo(4, 5, 3, 4, 5);
        // Llamada a los métodos calcularArea() y calcularPerimetro() de cada objeto
        System.out.println("El área del Cuadrado es: " + cuadrado.calcularArea());
        System.out.println("El perímetro del Cuadrado es: " + cuadrado.calcularPerimetro());
        
        System.out.println("El área del Círculo es: " + circulo.calcularArea());
        System.out.println("El perímetro del Círculo es: " + circulo.calcularPerimetro());
        
        System.out.println("El área del Triángulo: " + triangulo.calcularArea());
        System.out.println("El perímetro del Triángulo: " + triangulo.calcularPerimetro());
    }
}






