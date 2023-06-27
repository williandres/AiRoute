package Colecciones;
public class Persona {
    private String nombres;
    private String apellidos;
    private String direccion;
    private String genero;
    private int edad;
    public Persona(String nombres, String apellidos, String direccion, String genero, int edad) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.direccion = direccion;
        this.genero = genero;
        this.edad = edad;
    }
    public int getEdad() {
        return edad;
    }
    public void setEdad(int edad) {
        this.edad = edad;
    }
    public String getNombres() {
        return nombres;
    }
    public void setNombres(String nombres) {
        this.nombres = nombres;
    }
    public String getApellidos() {
        return apellidos;
    }
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }
    public String getDireccion() {
        return direccion;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    public String getGenero() {
        return genero;
    }
    public void setGenero(String genero) {
        this.genero = genero;
    }
    @Override
    public String toString() {
        String datos = "Nombre: " + getNombres() + " " + getApellidos()
                + " Dirección: " + getDireccion()
                + " Edad: " + getEdad() + " Genero: " + getGenero() + "\n";
        return datos;
    }
}