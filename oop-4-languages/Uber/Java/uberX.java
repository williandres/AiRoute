class Uberx extends Car{
    String brand;
    String model;

    public Uberx(String license, Account driver, String brand, String model){
        super(license, driver); //Llamar a la clase padre(metodo constructor) "Car"
        this.brand=brand; //Asignar a la clase hija "la actual"
        this.model=model;
    }
    void printDataCar() {
        super.printDataCar();
        System.out.println("Modelo: " + model + " Brand: " + brand);
    }
}