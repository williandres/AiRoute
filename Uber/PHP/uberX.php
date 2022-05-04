<?php
require_once('car.php');
class   UberX extends Car {
    public $brand;
    public $model;

    public function __construct($license, $driver,$brand, $model) {
    parent::__construct($license,$driver);//Llama a la clase padre volviendola una instancia del objeto***
    $this->brand = $brand;
    $this->model = $model;
    }
    public function setPassenger($passenger) {
        if ($passenger == 4) {
            $this->passenger = $passenger;
        }
        else {
            echo "Necesitas asignar 4 pasajeros
    ";
        }
    }
    public function printDataCar() {
        echo "
            Licencia: $this->license
            Driver: {$this->driver->name}
            Número de pasajeros: $this->passenger
            Model:$this->model
            Bran:$this->brand
        ";
      }

}