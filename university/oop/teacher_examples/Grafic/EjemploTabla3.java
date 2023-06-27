package Grafic;

import java.awt.BorderLayout;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;

// ============= Clases del Sistema ===================

// El Modelo controla todos los datos de la tabla
class ModeloDatos extends AbstractTableModel {
  Object datos[][] = {
    {"Uno","Dos","Tres","Cuatro"},
    {"Cinco","Seis","Siete","Ocho"},
    {"Nueve","Diez","Once","Doce"},
    {"Trece","Catorce","Quince","Dieciseis"},
  };
  
  // Esta clase muestra los datos en consola cuando se
  // produce un cambio en alguna de las casillas de la tabla
  class TablaListener implements TableModelListener {
    @Override
    public void tableChanged(TableModelEvent evt) {
      for( int i=0; i < datos.length; i++ ) {
        for( int j=0; j < datos[0].length; j++ )
          System.out.print( datos[i][j] + " " );
        System.out.println();
      }
    }
  }
  // Constructor
  ModeloDatos() {
    addTableModelListener(new TablaListener());
  }
  // Devuelve el número de columnas de la tabla
  @Override
  public int getColumnCount() { 
    return(datos[0].length); 
  }
  // Devuelve el número de filas de la tabla
  @Override
  public int getRowCount() { 
    return(datos.length);
  }
  // Devuelve el valor de una determinada casilla de la tabla
  // identificada mediante fila y columna
  @Override
  public Object getValueAt(int fila,int col){ 
    return(datos[fila][col]); 
  }
  // Cambia el valor que contiene una determinada casilla de
  // la tabla
  @Override
  public void setValueAt(Object valor,int fila,int col){
    datos[fila][col] = valor;
    // Indica que se ha cambiado
    fireTableDataChanged();
  }
  // Indica si la casilla identificada por fila y columna es
  // editable
  @Override
  public boolean isCellEditable(int fila,int col){ 
    return(true); 
  }
}       
// ============= Programa Principal ===================

public class EjemploTabla3 extends JPanel{
  public EjemploTabla3() {
    setLayout(new BorderLayout());
    JTable tabla = new JTable((TableModel) new ModeloDatos());
    // ScrollPane controla automáticamente en tamaño de la tabla,
    // y aparecerá una barra de desplazamiento cuando sea
    // necesario
    JScrollPane panel = new JScrollPane(tabla);
    add(panel,BorderLayout.CENTER);
  }
  
  public static void main(String args[]){
    JFrame frame = new JFrame("Muestra del uso de Java Swing");
    frame.addWindowListener(new WindowAdapter(){
      @Override
      public void windowClosing(WindowEvent evt) {
        System.exit(0);
      }
    } );
    frame.getContentPane().add(new EjemploTabla3(),BorderLayout.CENTER);
    frame.setSize(500,200);
    frame.setVisible(true);
  }
} 
