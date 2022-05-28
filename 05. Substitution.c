#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

// Declare the sub functions that are used to validate the key
int non_alpha_check(string cipher_key);
int repeate_check(string cipher_key);

int main(int argc, string argv[])
{
    if (argc == 2) // Validate the no of arguments
    {
        string key = argv[1];

        // Validate the key in 3 steps as below:
        // (1) Check if the length of key is equal to 26
        if (strlen(key) != 26)
        {
            printf("INVALID, the Key is not 26 letter long!\n");
            return 1;
        }
        // (2) Check if non-alphabets are in key, if yes, sub function returns 1, else 0
        else if (non_alpha_check(key) == 1)
        {
            printf("INVALID, there are non-alphabet letters in the Key!\n");
            return 1;
        }
        // (3) Check if Key letters repeat, if yes, sub function returns 1, else 0
        else if (repeate_check(key) == 1)
        {
            printf("INVALID, there are repeat letters in the key!\n");
            return 1;
        }
        else
        {
            // Ask the user for plaintext without a new line
            string input_string = get_string("plaintext:");
            int index;
            string output = input_string; // Keep it same as input to begin with

            for (int i = 0, n = strlen(input_string); i < n; i++)
            {
                int ord = input_string[i];
                if (ord > 64 && ord < 91) // Rule for capital letters
                {
                    index = ord - 65;
                    output[i] = toupper(key[index]);
                }

                else if (ord > 96 && ord < 123) // Rule for small letters
                {
                    index = ord - 97;
                    output[i] = tolower(key[index]);
                }
                else
                {
                    output[i] = input_string[i]; // For everything else
                }
            }
            printf("ciphertext:%s\n", output);
            return 0;
        }
    }
    else
    {
        printf("Invalid Argument\n");
        return 1;
    }
}


// Sub function that checks if there are non-alpha chars in the key and returns 0 if there are
int non_alpha_check(string cipher_key)
{
    int result;
    for (int i = 0, n = strlen(cipher_key), asci; i < n; i++)
    {
        asci = cipher_key[i];
        if ((asci > 64 && asci < 91) || (asci > 96 && asci < 123))
        {
            result = 0;
        }
        else
        {
            result = 1;
            break;
        }
    }
    return result;
}


int repeate_check(string cipher_key)
{
    int result = 0;
    for (int i = 0, n = strlen(cipher_key), asci; i < n; i++)
    {
        asci = cipher_key[i];
        for (int j = i + 1; j < n; j++)
        {
            if (cipher_key[j] == asci)
            {
                result = 1;
                break;
            }
        }
    }
    return result;
}