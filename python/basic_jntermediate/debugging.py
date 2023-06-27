def divisors(num):
    divisors = []
    for i in range(1, num + 1):
        if num % i == 1:
            divisors.append(i)
    return divisors

def run():
    try:
        num = int(input(" Write a number: "))
        if num < 1:
            raise AttributeError("Only positive numbers")
        print(divisors(num))
    except ValueError:
        print("Only numbers")
        run()
        return None
    except AttributeError as ae:
        print(ae)
        run()
        return None
    print(f'End')

# def run():
#     while True:
#         try:
#             num = int(input('Ingresa un número: '))
#             if num < 0:
#                 raise ValueError
#             print(divisors(num))
#             print("Terminó mi programa")
#             break
#         except ValueError:
#             print("Debes ingresar un entero positivo")
if __name__=="__main__":
    run()