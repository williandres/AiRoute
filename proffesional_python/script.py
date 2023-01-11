items = [
    {
        'product': 'camisa',
        'price': 100,
    },
    {
        'product': 'pantalones',
        'price': 300
    },
    {
        'product': 'pantalones 2',
        'price': 200
    }
]


def add_taxes(item):
    item = item.copy() # To not modify the original list
    item['taxes'] = item['price'] * .19
    item['price'] = item['price'] + 1

    return item

new_items = list(map(add_taxes, items))
print(items)
print("-----"*5)
print(new_items)

