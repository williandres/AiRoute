from car import Car
from account import Account
from payment import Payment



if __name__ == "__main__":
    print("Hola Mundo")
    
    car = Car("AMS234", Account("Andres Herrera", "ANDA876"))
    print(vars(car))
    print(vars(car.driver))

    payment= Payment(65415621)
    print(vars(payment))

    account= Account("pepe","papurepapap")
    print(vars(account))