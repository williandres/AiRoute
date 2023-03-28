package Colecciones;

public class Vehiculos {
    private String tipo;
    private String placa;
    private String marca;
    private int modelo;

    public Vehiculos(String tipo, String placa, String marca, int modelo) {
        super();
        this.tipo = tipo;
        this.placa = placa;
        this.marca = marca;
        this.modelo = modelo;
    }
    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public String getPlaca() {
        return placa;
    }
    public void setPlaca(String placa) {
        this.placa = placa;
    }
    public String getMarca() {
        return marca;
    }
    public void setMarca(String marca) {
        this.marca = marca;
    }
    public int getModelo() {
        return modelo;
    }
    public void setModelo(int modelo) {
        this.modelo = modelo;
    }
    @Override
    public String toString(){
        String datos = "Los datos del vehículo son:\n"+"Tipo:  " + getTipo()+
                       " Placa: " + getPlaca() + " Marca: " + getMarca() +
                       " Modelo:" + getModelo()+ "\n";
        return datos;
    }
    
}