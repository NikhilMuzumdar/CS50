import csv
import sys


def main():
    # TODO: Check for command-line usage
    if len(sys.argv) != 3:
        print("Invalid Command line Argument.\nEnter dna.py database_file.csv sequence.txt")
        return 1

    # TODO: Read database file into a variable
    database = []
    database_file = sys.argv[1]
    try:
        with open(database_file, mode="r") as file:
            for rows in csv.DictReader(file):
                database.append(rows)
    except:
        print("No such database file exists")
        return 1

    # TODO: Read DNA sequence file into a variable
    sequence_file = sys.argv[2]
    sequence = ""
    try:
        with open(sequence_file, mode="r") as file:
            sequence = file.read()
    except:
        print("No such sequence file exists")
        return 1

    # TODO: Find longest match of each STR in DNA sequence
    strs = []
    for str in list(database[0].keys())[1:]:
        strs.append({str: longest_match(sequence, str)})

    # TODO: Check database for matching profiles

    # create a dict list with unique hash code as key and name as value
    hashed_database = hash_database(database)

    # generate hash code for strs matches, check with the hashed database and return name
    str_key = hash_strs(strs)
    if str_key in hashed_database.keys():
        print(hashed_database[str_key])
    else:
        print("No match")

    return


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


def hash_database(database):
    hashed_database = {}
    for elements in database:
        hash_code = ""
        for key in list(elements.keys()):
            if key != "name":
                hash_code += key
                hash_code += elements[key]
        hashed_database[hash_code] = elements['name']
    return hashed_database


def hash_strs(strs):
    hash_code = ""
    for element in strs:
        hash_code += list(element.keys())[0]
        hash_code += str(list(element.values())[0])
    return hash_code


main()
