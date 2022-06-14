#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // Takes the height and validates if it's positive whole number //
    int height;
    do
    {
        height = get_int("Enter the height of the pyramid (positive whole number) ");
    }
    while (height < 1 || height > 8);

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
        printf("\n");
    }
}
