#include <cs50.h>

#include <stdio.h>

#include <math.h>

int main(void)
{
    // Get the credit card number from the user
    long cc;
    do
    {
        cc = get_long("Enter the credit card number: \n");
    }
    while (cc < 0);

    // Get hold of the total number of digits,
    // We require length of card for iterating for loop later
    long cc1 = cc; // Need a temp variable to hold card no
    int n_digits = 0; // Variable that will hold the number of digits
    do
    {
        cc1 /= 10;
        ++n_digits;
    }
    while (cc1 != 0);

    // At this stage we can check if the card is of valid length and proceed only if True
    if (n_digits == 13 || n_digits == 15 || n_digits == 16)
    {
        int even_sum = 0; // To store the sum (not literal sum if digit > 2) of even places
        int odd_sum = 0; // To store the sum of odd places
        long cc2 = cc; // Need to fiddle with the card no without affecting original
        int holder; // A variable that will store the digits during iteration

        for (int i = 0; i < n_digits; i++) // for loop to extract digits
        {
            holder = cc2 % 10;
            //  printf("Holder value is %i\n", holder);
            cc2 /= 10;

            if (i % 2 == 0) // If a digit is in ODD position (i is even as it starts from 0)
            {
                odd_sum += holder;
            }
            else // If a digit is in even position (i is odd)
            {
                holder *= 2; // Multiply by 2 as per Luhn's Algorithm requirement
                if (holder < 10) // if single digit
                {
                    even_sum += holder;
                }
                else
                {
                    even_sum += holder % 10; // Add the digit at Zero'th place
                    even_sum += holder / 10; // Add the digit at Ten'th place
                }
            }
        }

        // Final check, return outputs as desired
        int check_sum;
        check_sum = even_sum + odd_sum;
        if (check_sum % 10 == 0)
        {
            // Check which bank has issued the card
            int first_two;
            int first_one;
            first_two = cc / pow(10, n_digits - 2);
            first_one = cc / pow(10, n_digits - 1);

            if (first_two == 34 || first_two == 37)
            {
                printf("AMEX\n");
            }
            else if (first_two == 51 || first_two == 52 || first_two == 53 || first_two == 54 || first_two == 55)
            {
                printf("MASTERCARD\n");
            }
            else if (first_one == 4)
            {
                printf("VISA\n");
            }
            else
            {
                printf("INVALID\n");
            }
        }
        else
        {
            printf("INVALID\n");
        }
    }
    else // The check condition from begining when digits are not equal to 13, 15 or 16
    {
        printf("INVALID\n");
    }

}
