<?php
require_once('car.php');
class   UberBlack extends Car {
    public $typeCarAccepted;
    public $seatsMaterial;

    public function __construct($license, $driver,$typeCarAccepted, $seatsMaterial) {
    parent::__construct($license,$driver);//Llama a la clase padre volviendola una instancia del objeto***
    $this->typeCarAccepted = $typeCarAccepted;
    $this->seatsMaterial = $seatsMaterial;
    }

}