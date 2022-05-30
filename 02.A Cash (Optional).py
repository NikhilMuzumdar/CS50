import math
def n_coins():
  cents = None
  while True:
    try:
      cents = int(input("Change owed: "))
      if cents > 0:
        break
      else:
        continue
    except ValueError:
      print("Invalid Input")

  (quarter, dime, nickel, penny) = (0,0,0,0)
  quarter = math.floor(cents/25)
  cents = cents - quarter*25
  
  dime = math.floor(cents/10)
  cents = cents - dime*10
  
  nickel = math.floor(cents/5)
  cents = cents - nickel*5
  
  penny = cents
  
  coins = quarter + dime + nickel + penny
  print(coins)

while True:
  n_coins()