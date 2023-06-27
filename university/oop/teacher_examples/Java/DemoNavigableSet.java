package Colecciones;

import java.util.NavigableSet;
import java.util.TreeSet;



public class DemoNavigableSet {
    
    public static void main(String[] args) {
       NavigableSet<String> tree =  new TreeSet();
       
       tree.add("Fernanda");
       tree.add("Beatriz");
       tree.add("Amanda");
       tree.add("Zully");
       tree.add("Gloria2");
       tree.add("Gladys");
       tree.add("Jorge");
       tree.add("Gloria");
       tree.add("Gloan");
       tree.add("Gloen");
       
        System.out.println("Árbol: " + tree);
       
        String chk = "Graciela";
        
        if(tree.contains(chk)){
            System.out.println("Si está contenido en el árbol: " + chk);
        }else{
            System.out.println("NO está contenido en el árbol: " + chk);
        }
        System.out.println("El 1er dato es: " +  tree.first());
        System.out.println("El último dato es: " +  tree.last());
        
        String d = "Glo";
        System.out.println("El 1er dato es: " +  tree.higher(d));
        System.out.println("El 1er dato es: " +  tree.lower(d));
        
    }

}
