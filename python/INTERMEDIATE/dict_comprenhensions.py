from math import sqrt
def run():
    dict={}
    for i in range (1,101):
        if not i % 3 == 0:
            dict[i]=i**3
    dict={i: i**3 for i in range(1,101) if not i % 3 == 0}
    print (dict)

def challenge():
    cha={i: round(sqrt(i),3) for i in range (1,100)} # cha={i: round(i**0.5,3) for i in range (1,100)}
    print(cha)
if __name__=='__main__':
    # run()
    challenge()