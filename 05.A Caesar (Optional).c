#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

int is_number(string key);
int main(int argc, string argv[])
{
    if (argc == 2) // Validate the no of arguments
    {
        string key_check = argv[1];
        if (is_number(key_check) != 1) // A function that checks if there are non digits (0-9) in the key
        {
            int key = atoi(key_check);
            key = key % 26; // Any thing > 26 must be moded
            string input_text = get_string("plaintext: "); // Ask the user for input
            string cipher_text = input_text;

            for (int i = 0, n = strlen(input_text); i < n; i++)
            {
                int asci = input_text[i];
                char l;

                if (asci > 64 && asci < 91) // For capital letters
                {
                    if (asci + key > 90)
                    {
                        l = asci + key - 26;
                        cipher_text[i] = l;
                    }
                    else
                    {
                        l = asci + key;
                        cipher_text[i] = l;
                    }
                }

                else if (asci > 96 && asci < 123) // For smallcase letters
                {
                    if (asci + key > 122)
                    {
                        l = asci + key - 26;
                        cipher_text[i] = l;
                    }
                    else
                    {
                        l = asci + key;
                        cipher_text[i] = l;
                    }
                }

                else // For everything else
                {
                    cipher_text[i] = input_text[i];
                }
            }
            printf("ciphertext: %s\n", cipher_text);
        }
        else
        {
            printf("Invalid Key!\n");
            return 1;
        }
    }
    else
    {
        printf("Invalid Key!\n");
        return 1;
    }

}

int is_number(string key)
{
    int result = 0;
    for (int i = 0, n = strlen(key); i < n; i++)
    {
        if (isdigit(key[i]) == 0) // Use the builtin function in ctype.h
        {
            result = 1;
            break;
        }
    }
    return result;

}