def run():
    # list=[]
    # for i in range(1,101):
    #     if not i%3 ==  0:
    #         list.append(i**2)
    list=[i**2 for i in range(1,101) if not i%3 == 0]
    print(list)

def challenge():
    cha=[i for i in range(1,10000) if i%  4 == 0 and i % 6 == 0 and i % 9 == 0]
    """MCM -> cha=[i for i in range(1,10000) if i%36 == 0 ]"""
    print(cha)

if __name__ == '__main__':
    # run()
    challenge()