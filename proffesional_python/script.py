def filter_by_length(words):
   res = list(filter(lambda x: len(x) >= 4, words))
   return res

words = ['amor', 'sol', 'piedra', 'día']
response = filter_by_length(words)
print(response)

