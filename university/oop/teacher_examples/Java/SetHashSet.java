package Colecciones;

import java.util.HashSet;
import java.util.Set;

public class SetHashSet {
    public static void main(String[] args) {
        Set<String> objeto = new HashSet();
        
        objeto.add("Disco Duro");
        objeto.add("Memoria RAM");
        objeto.add("Computador de escritorio");
        objeto.add("Disco Duro");
        
        for(String elemento: objeto){
            System.out.println(elemento);
        }
        
    }
}
