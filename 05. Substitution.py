alpha_list = [chr(n) for n in list(range(97, 123)) + list(range(65, 91))] # To store all alphabhets, will need this later


# A function to check if the key has only alphabets and return True
def alpha_check(key):
    for l in key:
        if l not in alpha_list:
            return True

# A function to check if there are no repeates in key and return True
def repeat_check(key):
  n = len(key)
  for i in range(n):
    for j in range(i+1, n):
      if key[i] in key[j:n]:
        return True

# Ask the user for the cypher key
key = input("Enter cipher key: ")

# Check key length is 26
if len(key) != 26:
  print('INVALID, the Key is not 26 letter long!\n')

# Check if non alphabet chars exist
elif alpha_check(key):
  print("INVALID, there are non-alphabet letters in the Key!\n")

# Check for repetition
elif repeat_check(key):
  print("INVALID, repetitions in the Key!\n")

# If the key passes above checks
else:
  text = input("plaintext:") # Promt user for text input
  output = ""
  for i in range(len(text)):
  # Handle upper case alpha
    if text[i] in alpha_list[26::]:
      output += key[i].upper() # encode as per the key in the letter position
      
  # Handle lower case alpha 
    elif text[i] in alpha_list[0:26]:
      output += key[i].lower() # encode as per the key in the letter position

  # Leave the rest unchanged
    else:
      output += text[i]
  
print(f"cyphertext:{output}")