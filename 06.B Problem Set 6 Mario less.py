# Define a function that gets height and handles errors
def get_height():
    while True:
        try:
            height = int(input(" Enter height in range 1 and 9 (both included): "))
            if height in range(1, 9):
                break
        except:
            continue
    return height


# Get height from the user
height = get_height()


# Loop through for printing
for i in range(height):
    left_space = " " * (height-i-1)
    hashes = "#" * (i+1)
    print(f"{left_space}{hashes}")
