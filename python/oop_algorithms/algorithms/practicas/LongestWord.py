def LongestWord(sen):
    i=0
    j=-1
    ln=0
    while i < len(sen):
        simbol=ord(sen[i])
        if simbol<48 or  57<simbol< 65 or  90<simbol< 97 or 122<simbol< 128:
            if i-j>ln:
                ln=i-j
                long_word=sen[j+1:i]
            j=i
        i+=1
    if len(sen)-j>ln:
        long_word=sen[j+1:]
    return long_word

# keep this function call here
print(LongestWord(input()))