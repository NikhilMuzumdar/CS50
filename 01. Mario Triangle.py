height = None
while True:
    try:
      height = int(input("Enter height (min 1, max 8): "))
      if height in list(range(1,9)):
        break
      else:
        continue
    except ValueError:
        continue

for n in range(1,height+1):
  print(f'{" "*(height-n)}{"#"*n}  {"#"*n}')
  
