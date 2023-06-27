package Colecciones;

//import java.util.*;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

public class SetTreeSetOrdenado {
    public static void main(String args[]) {
        Integer arreglo[] = {100, 50, 1, 200, -100, 50, 56, 35, 20, 1};
        Set<Integer> datos = new HashSet<>();
        try {
            System.out.println("Datos Iniciales: ");
            System.out.println(Arrays.toString(arreglo)); // se imprime sin for
//            System.out.println("Otra forma de imprimir:");
//            System.out.println(Arrays.asList(arreglo)); // se imprime sin for

            // carga los elementos al conjunto
            for (int i = 0; i < arreglo.length; i++) {
                datos.add(arreglo[i]);
            }

            System.out.println("Datos sin repetidos: ");
            System.out.println(datos);
            TreeSet ordenado = new TreeSet<Integer>(datos);
            System.out.println("Datos Ordenados: ");
            System.out.println(ordenado);

        } catch (Exception e) {
        }
        //Ejemplo de arreglo multidimensional
        int otroArreglo[][] = {{1,2,3},{4,5,6},{7,8,9},{-1,-2,-3}};
        System.out.println(Arrays.deepToString(otroArreglo)); 
    }
}
