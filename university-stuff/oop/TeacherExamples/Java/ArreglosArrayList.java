package Colecciones;

import java.util.ArrayList;

public class ArreglosArrayList {

    public static void main(String[] args) {
       ArrayList<Vehiculos> vehiculo = new ArrayList<Vehiculos>();
      
       vehiculo.add(new Vehiculos("Particular","AAA123","Mercedes",2018));
       vehiculo.add(new Vehiculos("Público","SAA456","Chevrolet",2013));
       vehiculo.add(new Vehiculos("Particular","AKC332","Volvo",2022));
       vehiculo.add(new Vehiculos("Público","SAA278","Hyundai",2021));
       
       for (int i = 0; i < vehiculo.size(); i++){
         System.out.println(vehiculo.get(i).toString());
    }
    }
}


