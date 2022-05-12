import os
import random as r
from termcolor import colored, cprint

print_red = lambda x: cprint(x, 'red')
print_green = lambda x: cprint(x, 'green')

def title():
    print("""

 ▄         ▄       ▄▄▄▄▄▄▄▄▄▄▄       ▄▄        ▄       ▄▄▄▄▄▄▄▄▄▄▄       ▄▄       ▄▄       ▄▄▄▄▄▄▄▄▄▄▄       ▄▄        ▄
▐░▌       ▐░▌     ▐░░░░░░░░░░░▌     ▐░░▌      ▐░▌     ▐░░░░░░░░░░░▌     ▐░░▌     ▐░░▌     ▐░░░░░░░░░░░▌     ▐░░▌      ▐░▌
▐░▌       ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌░▌     ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀      ▐░▌░▌   ▐░▐░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌░▌     ▐░▌
▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌▐░▌    ▐░▌     ▐░▌               ▐░▌▐░▌ ▐░▌▐░▌     ▐░▌       ▐░▌     ▐░▌▐░▌    ▐░▌
▐░█▄▄▄▄▄▄▄█░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌ ▐░▌   ▐░▌     ▐░▌ ▄▄▄▄▄▄▄▄      ▐░▌ ▐░▐░▌ ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌ ▐░▌   ▐░▌
▐░░░░░░░░░░░▌     ▐░░░░░░░░░░░▌     ▐░▌  ▐░▌  ▐░▌     ▐░▌▐░░░░░░░░▌     ▐░▌  ▐░▌  ▐░▌     ▐░░░░░░░░░░░▌     ▐░▌  ▐░▌  ▐░▌
▐░█▀▀▀▀▀▀▀█░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌   ▐░▌ ▐░▌     ▐░▌ ▀▀▀▀▀▀█░▌     ▐░▌   ▀   ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌   ▐░▌ ▐░▌
▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌    ▐░▌▐░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌    ▐░▌▐░▌
▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌     ▐░▐░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌     ▐░▐░▌
▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌      ▐░░▌     ▐░░░░░░░░░░░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌      ▐░░▌
 ▀         ▀       ▀         ▀       ▀        ▀▀       ▀▀▀▀▀▀▀▀▀▀▀       ▀         ▀       ▀         ▀       ▀        ▀▀

""")

def ui(hang):
    os.system('cls')
    title()
    ui = " ".join(hang)
    print_red(ui)
    print("\n")

def hangman(word):
    word_split = list(word)
    hang = [ "__" for i in word_split]
    win = False
    while win == False:
        ui(hang)
        letter = input("Please enter a letter: ")
        for i in range(0, len(word_split)):
            if letter == word_split[i]:
                hang[i] = letter
        if hang == word_split:
            win = True
            ui(hang)
            print_green("YOU WIN !!!!!")
            print("\n"*10)

def random_word():
    with open("./files/data.txt","r", encoding = "utf-8") as f:
        random_number = r.randint(1, 171)
        i = 1
        for line in f:
            if i == random_number:
                word = line.rstrip()
            line.rstrip()
            i +=1
    return word

def run():
    hangman(random_word())

if __name__=='__main__':
    run()