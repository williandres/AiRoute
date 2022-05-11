import os.path as os

def read():
    file = input("Filename to read : ")
    try:
        with open(f"./files/{file}.txt", "r" , encoding = "utf-8") as f:
            print(f.read())
    except FileNotFoundError:
        print("File doesn't exist")
    return None

def write():
    file = input("The name of your new file : ")
    with open(f"./files/{file}.txt", "w", encoding = "utf-8") as f:
            f.write(input("Put a tittle for your file : "))
            f.write("\n")
    return None

def append():
    file = input("Filename to add caracthers : ")
    if not os.exists(f'./files/{file}.txt'):
        print("Try again")
        return None
    with open(f"./files/{file}.txt", "a", encoding = "utf-8") as f:
        while True:
            name = input("Add carahcters to your file (x to cancel) : ")
            if name == "x":
                print(f'Finished')
                break
            f.write(name)
            f.write("\n")
    return None

def run():
    while True:
        print("""
        What do you want to do?
        1. Create a new file .txt
        2. Add carachters to an existing file
        3. See list the content of a file (list)
        4. Exit
        """)
        option = input("Select an option: ")
        if option == '1':
            write()
        if option == '2':
            append()
        if option == '3':
            read()
        if option == '4':
            print(f"End")
            break
    return None

if __name__=='__main__':
    run()