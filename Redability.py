# Ask for user text input
sentence = input("Enter your sentence :")

# count letters
alpha_list = [chr(n) for n in list(range(97, 123)) + list(range(65, 91))]
letter_count = 0
for l in sentence:
    if l in alpha_list:
        letter_count += 1

# Count words by counting spaces + 1
word_count = 1
for l in sentence:
    if l == " ":
        word_count += 1

# Count Sentences, characters that ends with [".", "!", "?"]
sentence_count = 0
for l in sentence:
    if l in [".", "!", "?"]:
        sentence_count += 1

# print(f"Word count: {word_count}\nLetter count: {letter_count}\nSentence count: {sentence_count}")

L = (letter_count * 100) / word_count
S = (sentence_count * 100) / word_count
coleman_index = round((0.0588 * L - 0.296 * S - 15.8), 0)

if coleman_index < 1:
    print("Before Grade 1")
elif coleman_index >= 16:
    print('Grade 16+')
else:
    print(f"Grade {coleman_index}")
