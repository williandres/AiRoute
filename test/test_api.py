import openai
import os

# Configura la API key
openai.api_key = os.environ["OPENAI_API_KEY"]

# Realiza una solicitud de prueba para asegurarse de que la API key esté configurada correctamente
response = openai.Completion.create(engine="davinci", prompt="di hola", max_tokens=5)
print(response.choices[0].text)



def binary_search(list, item):
    low = 0
    high = len(list) - 1

    while low <= high:
        mid = (low + high) // 2
        guess = list[mid]
        if guess == item:
            return mid
        if guess > item:
            high = mid - 1
        else:
            low = mid + 1
    return None

my_list = [1, 3, 5, 7, 9]

print(binary_search(my_list, 3)) # => 1
print(binary_search(my_list, -1)) # => None