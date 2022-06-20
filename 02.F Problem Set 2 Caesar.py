key = None

while True:
    try:
      key = int(input("Enter key : "))
      if type(key) == int:
        break
      else:
        continue
    except ValueError:
      print("Invalid Input")

text = input("cyphertext  ")
cipher_text = ""
key = key % 26

for l in text:
  asci = ord(l)
  if (asci > 64 and asci < 91): # For capital letters
    if asci + key > 90:
      cipher_text += chr(asci + key - 26)
    else:
      cipher_text += chr(asci + key)

  elif (asci > 96 and asci < 123): # For smallcase letters
    if asci + key > 122:
      cipher_text += chr(asci + key - 26)
    else:
      cipher_text += chr(asci + key)

  else:
    cipher_text += l

print(cipher_text)
