#include <stdio.h>
#include <stdlib.h>
#include <cs50.h>
#include <stdint.h> // required to define uint8_t

typedef uint8_t BYTE;

int main(int argc, char *argv[])
{
    BYTE buffer[512]; // Declare an array 512 long to store the read values from file
    char file_name[8] = {0};
    int file_count = 0;

    FILE *output = NULL;

    if (argc != 2)
    {
        printf("Invalid input, In the command line, enter filename to be recovered!\n");
        return 1;
    }
    else
    {
        FILE *card = fopen(argv[1], "r");
        if (card == NULL)
        {
            printf("Could not open the file - %s\n", argv[1]);
            return 1;
        }

        // In a while loop start reading the memoryy till the end (Use sizeof)
        while (fread(buffer, sizeof(BYTE), 512, card) == 512) // sizeof(BYTE) returns 1
        {
            // check if jpeg begening pattern is found
            if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
            {
                if (file_count == 0) // for the first time need not close the opened file as there is none
                {
                    sprintf(file_name, "%03i.jpg", file_count);
                    output = fopen(file_name, "a");
                    fwrite(buffer, sizeof(BYTE), 512, output);
                    file_count ++;
                }
                else if (file_count > 0)
                {
                    fclose(output); // close the file opened previously
                    sprintf(file_name, "%03i.jpg", file_count);
                    output = fopen(file_name, "a");
                    fwrite(buffer, sizeof(BYTE), 512, output);
                    file_count ++;
                }
            }
            else if (file_count > 0)
            {
                fwrite(buffer, sizeof(BYTE), 512, output);
            }
        }
        fclose(output);
        fclose(card);
    }
}