package Colecciones;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.Iterator;

public class DemoHashMap {

    public static void main(String[] args) {
        HashMap<String, Persona> personal = new HashMap<String, Persona>();

        personal.put("1", new Persona("Luis", "Rodriguez", "Carrera 500#400-01", "Masculino", 26));
        personal.put("2", new Persona("Mauricio", "Molinare", "Carrera 400#300-01", "Masculino", 25));
        personal.put("3", new Persona("Bertha", "Marín", "Carrera 300#200-01", "Femenino", 20));

        System.out.println(personal);

        //Modifica la llave 2
        personal.put("2", new Persona("María", "Molinare", "Carrera 400#300-01", "Masculino", 25));
        System.out.println(personal);
        
        System.out.println("Imprimiendo:\n" + personal.entrySet());
        
        for(Map.Entry<String,Persona> datos: personal.entrySet() ){
            String llave = datos.getKey();
            Persona valor = datos.getValue();
            System.out.println("Llave: " + llave);
            System.out.println("Valor: " + valor);
        }
        
        // Consigue el conjunto Llave - Valor
        Set entSet = personal.entrySet(); // define el conjunto
        Iterator it = entSet.iterator(); // define un iterador
 
  }      // Itera sobre todas las entradas del DemoHashMap
////        System.out.println("HashMap Llave - Valor : ");
//        while(it.hasNext()){
//           Map.Entry dato = (Map.Entry)it.next();
//           System.out.println("Llave: "+ dato.getKey() + " & " + " El valor es: "+ dato.getValue());
//        
//    }
}
