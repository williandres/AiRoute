<?php
require_once('car.php');
class   UberPool extends Car {
    public $brand;
    public $model;

    public function __construct($license, $driver,$brand, $model) {
    parent::__construct($license,$driver);//Llama a la clase padre volviendola una instancia del objeto***
    $this->brand = $brand;
    $this->model = $model;
    }

}