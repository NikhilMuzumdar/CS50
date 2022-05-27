// Declare library headers
#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

// Include the sub functions
int count_letters(string text);
int count_words(string text);
int count_scentences(string text);

// The main function
int main(void)
{
    string user_input = get_string("Enter your scentence: ");

    // below variables declared as float to account for calculation errors of L and S
    float letters = count_letters(user_input);
    float words = count_words(user_input);
    float scentences = count_scentences(user_input);

    // printf("The letter count is: %.1f\n", letters);
    // printf("The word count is: %.1f\n", words);
    // printf("The Scentence count is: %.1f\n", scentences);

    float L; // L is the average number of letters per 100 words; Letters / Words x 100
    L = (letters * 100) / words;

    float S; // S is the average number of sentences per 100 words; Scentence / Words / 100
    S = (scentences * 100) / words;

    // printf("L Value is %.2f, S Value is %.2f\n", L, S);

    float coleman_index;
    coleman_index = 0.0588 * L - 0.296 * S - 15.8;
    int grade = round(coleman_index);

    // printf("The Coleman Index is %2f\n", coleman_index);
    // printf("The Grade is %i\n", grade);

    if (grade < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (grade >= 1 && grade < 16)
    {
        printf("Grade %i\n", grade);
    }
    else
    {
        printf("Grade 16+\n");
    }

}

// Count letters
int count_letters(string text)
{
    int letter_count = 0;
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        int ord = tolower(text[i]);
        if (ord > 96 && ord < 123)
        {
            letter_count ++;
        }
    }
    return letter_count;
}

// Count words by counting spaces + 1
int count_words(string text)
{
    int word_count = 1;
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        int ord = text[i];
        if (ord == 32)
        {
            word_count ++;
        }
    }
    return word_count;
}

// Count Scentences, characters that ends with [".", "!", "?"]
int count_scentences(string text)
{
    int scentence_count = 0;
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        int ord = text[i];
        if (ord == 46 || ord == 33 || ord == 63)
        {
            scentence_count ++;
        }
    }
    return scentence_count;
}