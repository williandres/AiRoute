package Colecciones;

import java.util.Set;
import java.util.TreeSet;

public class SetTreeSet {

    public static void main(String[] args) {
        // Crea un arbol ordenado sin repetir elementos
        Set<String> tree = new TreeSet<String>();

        tree.add("Carlos");
        tree.add("Beatriz");
        tree.add("Ana");
        tree.add("Alberto");
        
        tree.add("Carlos");


        System.out.println(tree); //Imprime en forma ordenada

    }

}
