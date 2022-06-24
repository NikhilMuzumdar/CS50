def set_password(length):
    import random
    password = ""
    for _ in range(length):
        password += str(random.randint(0, 9))
    return password

def break_password(n_digits, password):
    import time
    s = time.time()
    start = "0000"
    while int(start) != int(password) and len(start) <= n_digits:
        start = str((int(start) + 1)).zfill(n_digits+1-len(start))
        # time.sleep(1)
    e = time.time()
    print(f"The password broken by brute force is: {start.zfill(n_digits+1-len(start))}\tTook {e-s:.2f} seconds to break")


def main(n_dig=5):
    p = set_password(n_dig)
    break_password(n_dig, p)

for i in range(4):
    main(8)

