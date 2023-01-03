from account import Account

class Car:
    id          = int
    license     = str
    driver      = Account("","")
    passegenger = int

    def __init__(self, license, driver):  ##__init__ es un metodo constructor
        self.license    = license
        self.driver     = driver