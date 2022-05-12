import os
import random as r

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

def hangman(word):
    word_split = list(word)
    hang = [ " " for i in word_split]
    win = False
    while win == False:
        os.system('cls')
        title()
        print(hang)
        print("\n")
        letter = input("Please enter a letter: ")
        for i in range(0, len(word_split)):
            if letter == word_split[i]:
                hang[i] = letter
        if hang == word_split:
            win = True
            print(f"You Win :) the word is {hang}")

def run():
    with open("./files/data.txt","r", encoding = "utf-8") as f:
        random_number = r.randint(1, 171)
        i = 1
        for line in f:
            if i == random_number:
                word = line.rstrip()
            line.rstrip()
            i +=1
    hangman(word)

if __name__=='__main__':
    run()