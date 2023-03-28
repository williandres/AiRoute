package Colecciones;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class ArreglosLinkedList {

    public static void main(String[] args) {
       List<Vehiculos> vehiculo = new LinkedList<Vehiculos>();
       
       vehiculo.add(new Vehiculos("Particular","AAA123","Mercedes",2018));
       vehiculo.add(new Vehiculos("Público","SAA456","Chevrolet",2010));
       
       Iterator it = vehiculo.iterator();
       
       while(it.hasNext()){
           Vehiculos elemento = (Vehiculos) it.next();
           System.out.println(elemento.toString());
       }
    }
}

