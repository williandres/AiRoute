def divisors(num):
    divisors = [ i for i in range(1, num+1) if num % i == 0]
    return divisors


def run():
    num = input('Enter a number: ')
    assert num.replace("-","").isnumeric(), "Only numbers"
    assert int(num) >= 0, "Only positive numbers"
    print(divisors(int(num)))
    print("End")


if __name__ == '__main__':
    run()