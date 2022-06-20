#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // Takes the height and validates if it's positive whole number //
    int height;
    do
    {
        height = get_int("Enter the height of the pyramid (positive whole number) ");
    } while (height < 1 || height > 8);
    // Print the Pyramid //
    // Main for loop to iterate through the height.
    // It is important that i starts from 1 and not 0, else the loop will execute to print a blank line
    for (int i = 1; i <= height; i++)
    {
        // LEFT SIDE
        for (int j = 0; j < (height - i); j++) // This for loop takes care of the left blank spaces
            if (height != 1)                   // if the height is 1, no blank spaces are required
            {
                printf(" ");
            }
        for (int k = 0; k < i; k++) // This for loop prints the left Hashes after the blank spaces
        {
            printf("#");
        }

        // Double spaces in between left and right
        printf("  "); // This is the gap that divides the left and the right

        // RIGHT SIDE
        for (int l = 0; l < i; l++) // This for loop prints the right Hashes after the blank spaces
        {
            printf("#");
        }
        printf("\n"); // After the line print is over, we go to the new line to print it.
    }
}
