def multiply_numbers(numbers):
    result = list(map(lambda x: x*2, numbers))
    return result

numbers = [2, 4, 5, 6, 8]
response = multiply_numbers(numbers)
print(response)

