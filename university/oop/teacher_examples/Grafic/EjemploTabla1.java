package Grafic;

import java.awt.Frame;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.*;

public class EjemploTabla1 extends JFrame {

    public EjemploTabla1() {
        setTitle("Medalleria Juegos Olimpicos Tokyo 2020");
        String[] encabezados = {"Pais", "Oro", "Plata", "Bronce"};
        String[][] valores = {
            {"Estados Unidos", "39", "41", "33"},
            {"China", "38", "32", "18"},
            {"Japón", "27", "14", "17"},
            {"Reino Unido","22", "21", "22"},
            {"ROC", "20", "28", "23"},
            {"Australia","17","7","22"},
            {"Países Bajos","10","12","14"},
            {"Francia","10","12","11"},
            {"Alemania","10","11","16"},
            {"Italia","10","10","20"}
        };
        JTable table = new JTable(valores, encabezados);
        JScrollPane jsp = new JScrollPane(table);
        add(jsp);
        pack();
        setVisible(true);
        
    }

    public static void main(String[] args) {
        new EjemploTabla1();
//      Frame frame = new EjemploTabla1();
//      frame.setSize(600, 150);
//      frame.addWindowListener(new WindowAdapter(){
//        @Override
//        public void windowClosing(WindowEvent evt){
//          System.exit(0);
//        }
//      } );
    }
}