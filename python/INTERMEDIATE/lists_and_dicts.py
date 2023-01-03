def run():
    my_list = [1, "Hello", True, 4.5]
    my_dict = {"firstname": "Facundo", "lastname": "Lanon"}

    super_list = [
        {"firstname": "Facundo", "lastname": "Mondongo"},
        {"firstname": "Miguel", "lastname": "Rodriguez"},
        {"firstname": "Pablo", "lastname": "Trinidad"},
        {"firstname": "Susana", "lastname": "Martinez"},
        {"firstname": "Josi", "lastname": "Fernandez"},
    ]

    super_dict = {
        "natural_nums": [1, 2, 3, 4, 5],
        "integer_nums": [-1, -2, 3, 0, 1],
        "floating_nums": [1.1, 4.55, 6.43],
    }

    for key, value in super_dict.items():
        print(key, ">", value)

    for i in range (0, len(super_list)):
        print(super_list[i])

    """for values in super_list:
            for key, value in values.items():
                print(f'{key} - {value}')"""

    """for i in super_list:
            for key, values in i.items():
                print(key,": ", values);"""

    """for i in super_list:
	        print(i.items())"""

if __name__ == '__main__':
    run()