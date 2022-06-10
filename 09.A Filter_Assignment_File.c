#include "helpers.h"
#include <stdio.h>
#include <math.h>

int max(float a);
RGBTRIPLE average(int i, int j, int height, int width, RGBTRIPLE image_copy[height][width]);

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    float grey; // To store the average value
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            grey = (float)(image[i][j].rgbtBlue + image[i][j].rgbtGreen + image[i][j].rgbtRed) / 3; // Compute average in a loop
            image[i][j].rgbtBlue = (int) round(grey); // plug into individual channels
            image[i][j].rgbtGreen = (int) round(grey); // plug into individual channels
            image[i][j].rgbtRed = (int) round(grey); // plug into individual channels
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    float sepiaRed, sepiaGreen, sepiaBlue; // Variables that store the computed values
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            sepiaRed = max(.393 * (float) image[i][j].rgbtRed + .769 * (float) image[i][j].rgbtGreen + .189 * (float) image[i][j].rgbtBlue);
            sepiaGreen = max(.349 * (float) image[i][j].rgbtRed + .686 * (float) image[i][j].rgbtGreen + .168 * (float) image[i][j].rgbtBlue);
            sepiaBlue = max(.272 * (float) image[i][j].rgbtRed + .534 * (float) image[i][j].rgbtGreen + .131 * (float) image[i][j].rgbtBlue);

            image[i][j].rgbtRed = sepiaRed;
            image[i][j].rgbtGreen = sepiaGreen;
            image[i][j].rgbtBlue = sepiaBlue;
        }
    }
    return;
}

// Used for Sepia function
int max(float a)
{
    if (a > 255)
    {
        return 255;
    }
    return (int) round(a);
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++) // Reverse a row / array
        {
            temp = image[i][j];
            image[i][j] = image[i][width - j - 1];
            image[i][width - j - 1] = temp;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE image_copy[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image_copy[i][j] = image[i][j];
        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = average(i, j, height, width, image_copy);
        }
    }
    return;
}

// A function to return a RGB triple average
RGBTRIPLE average(int i, int j, int height, int width, RGBTRIPLE image_copy[height][width])
{
    RGBTRIPLE out;
    float sum_red = 0, sum_green = 0, sum_blue = 0;
    float count = 0;
    for (int k = i - 1; k < i + 2; k++)
    {
        for (int l = j - 1; l < j + 2; l++)
        {
            if (k < 0 || l < 0 || k >= height || l >= width)
            {
                continue;
            }
            else
            {
                sum_red += image_copy[k][l].rgbtRed;
                sum_green += image_copy[k][l].rgbtGreen;
                sum_blue += image_copy[k][l].rgbtBlue;

                count ++;
            }
        }
    }

    out.rgbtRed = (int) round(sum_red / count);
    out.rgbtGreen = (int) round(sum_green / count);
    out.rgbtBlue = (int) round(sum_blue / count);

    return out;
}