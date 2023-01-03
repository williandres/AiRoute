import os
import random as r
from termcolor import colored, cprint
from pyfiglet import Figlet

print_red = lambda x: cprint(x, 'red')
print_green = lambda x: cprint(x, 'green')
pf = Figlet(font = "standard")

with open("./files/score.csv","r", encoding = "utf-8") as f:
    titles = f.readline().split(",")
    scores = f.readline().split(",")
    best_try = scores[0]
    best_time = scores[1]
    high_score = scores[2]

def title():
    print(f"""
------------------------------------------------------S P A N I S H-----------------------------------------------------------
|    ▄         ▄       ▄▄▄▄▄▄▄▄▄▄▄       ▄▄        ▄       ▄▄▄▄▄▄▄▄▄▄▄       ▄▄       ▄▄       ▄▄▄▄▄▄▄▄▄▄▄       ▄▄        ▄ |
|   ▐░▌       ▐░▌     ▐░░░░░░░░░░░▌     ▐░░▌      ▐░▌     ▐░░░░░░░░░░░▌     ▐░░▌     ▐░░▌     ▐░░░░░░░░░░░▌     ▐░░▌      ▐░▌|
|   ▐░▌       ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌░▌     ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀      ▐░▌░▌   ▐░▐░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌░▌     ▐░▌|
|   ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌▐░▌    ▐░▌     ▐░▌               ▐░▌▐░▌ ▐░▌▐░▌     ▐░▌       ▐░▌     ▐░▌▐░▌    ▐░▌|
|   ▐░█▄▄▄▄▄▄▄█░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌ ▐░▌   ▐░▌     ▐░▌ ▄▄▄▄▄▄▄▄      ▐░▌ ▐░▐░▌ ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌ ▐░▌   ▐░▌|
|   ▐░░░░░░░░░░░▌     ▐░░░░░░░░░░░▌     ▐░▌  ▐░▌  ▐░▌     ▐░▌▐░░░░░░░░▌     ▐░▌  ▐░▌  ▐░▌     ▐░░░░░░░░░░░▌     ▐░▌  ▐░▌  ▐░▌|
|   ▐░█▀▀▀▀▀▀▀█░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌   ▐░▌ ▐░▌     ▐░▌ ▀▀▀▀▀▀█░▌     ▐░▌   ▀   ▐░▌     ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌   ▐░▌ ▐░▌|
|   ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌    ▐░▌▐░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌    ▐░▌▐░▌|
|   ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌     ▐░▐░▌     ▐░█▄▄▄▄▄▄▄█░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌     ▐░▐░▌|
|   ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌      ▐░░▌     ▐░░░░░░░░░░░▌     ▐░▌       ▐░▌     ▐░▌       ▐░▌     ▐░▌      ▐░░▌|
|    ▀         ▀       ▀         ▀       ▀        ▀▀       ▀▀▀▀▀▀▀▀▀▀▀       ▀         ▀       ▀         ▀       ▀        ▀▀ |
------------------------------------------------------S P A N I S H-----------------------------------------------------------
Found a word using only one letter per try.
You can improve your score doing that with less try's and more faster.              ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■

                                                                                        Best number of attempts: {best_try}
                                                                                        Best time: {best_time}
                                                                                        High score: {high_score}

                                                                                    ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■ ■
""")

def ui(hang, attempts):
    os.system('cls')
    title()
    ui = " ".join(hang)
    print_red(ui)
    print(f"Attempts: {attempts}")
    print("\n")

def scores(attempts):
    print(f"Attempts: {attempts}")
    if attempts <= int(best_try):
        with open("./files/score.csv","w", encoding = "utf-8") as f:
            f.write(",".join(titles))
            f.write(f'{attempts},{best_time},{high_score}')
        print_green("""
    Congratulations, you earn a new record!
    Restart and you will see the new mark
""")

def ui_win(hang, attempts):
    os.system('cls')
    title()
    ui = " ".join(hang)
    print_green(ui)
    print("\n")
    print(colored(pf.renderText("You Win !!!"), 'green'))
    scores(attempts)
    print("\n"*3)
    again = input("Play again?( y / n ): ")
    if again == "y":
        run()
    else:
        print("Thanks for playing")
        return None

def hangman(word_split):
    hang = [ "__" for i in word_split]
    attempts = 0
    win = False
    while win == False:
        ui(hang, attempts)
        letter = input("Please enter a letter: ")
        attempts += 1
        for i in range(0, len(word_split)):
            if letter == word_split[i]:
                hang[i] = letter
        if hang == word_split:
            win = True
            ui_win(hang, attempts)

def random_word():
    with open("./files/data.txt","r", encoding = "utf-8") as f:
        random_number = r.randint(1, 171)
        i = 1
        for line in f:
            if i == random_number:
                word = line.rstrip()
            line.rstrip()
            i +=1
    word_split = list(word)
    return word_split

def run():
    hangman(random_word())

if __name__=='__main__':
    run()