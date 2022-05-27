 # Points assigned to each letter of the alphabet
POINTS = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]


def compute_score(word):
  sum = 0
  word = word.lower()
  for c in word:
    if ord(c) in range(97, 123):
      sum += POINTS[ord(c)-97]
  return sum

word1 = input("Player 1: ")
word2 = input("Player 2: ")

(score1, score2) = (compute_score(word1), compute_score(word2))

if score1 > score2:
  print("Player 1 wins!\n")
elif score1 < score2:
  print("Player 2 wins!\n")
else:
  print("Tie!\n")



      
    