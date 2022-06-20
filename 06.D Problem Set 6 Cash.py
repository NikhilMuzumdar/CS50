import math


def n_coins():
    cents = 0
    while True:  # This while loop validates the user input
        try:
            cents = float(input("Change owed: "))
            if cents > 0:
                cents = cents * 100
                break
            else:
                continue
        except ValueError:
            print("Invalid Input")
            continue

    (quarter, dime, nickel, penny) = (0, 0, 0, 0)
    quarter = math.floor(cents / 25)  # Calculate No of quarters
    cents = cents - quarter * 25  # Substract  No of cents

    dime = math.floor(cents / 10)  # Calculate  No of
    cents = cents - dime * 10

    nickel = math.floor(cents / 5)  # Calculate  No of Nickel
    cents = cents - nickel * 5

    penny = cents

    coins = quarter + dime + nickel + penny
    print(int(coins))
