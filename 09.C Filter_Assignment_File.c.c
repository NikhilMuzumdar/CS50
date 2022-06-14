#include "helpers.h"
#include <stdio.h>
#include <math.h>

typedef struct
{
    int  rgbtBlue;
    int  rgbtGreen;
    int  rgbtRed;
}
INTTRIPLE;


int max(double a);
RGBTRIPLE average(int i, int j, int height, int width, RGBTRIPLE image_copy[height][width]);
RGBTRIPLE sobel(int i, int j, int height, int width, RGBTRIPLE image_copy[height + 2][width + 2]);
INTTRIPLE factor(RGBTRIPLE triple, int factor);
RGBTRIPLE suqare_sum(INTTRIPLE triple_one, INTTRIPLE triple_two);

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

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE image_copy[height + 2][width + 2]; // This will be of dimension height + 1 x width + 1

    RGBTRIPLE zero;
    zero.rgbtRed = 0;
    zero.rgbtBlue = 0;
    zero.rgbtGreen = 0;

    for (int i = 0; i < height + 2; i++) // Produce a image copy adding zero value border on all sides
    {
        for (int j = 0; j < width + 2; j++)
        {
            if (i == 0 || j == 0 || i == height + 1 || j == width + 1)
            {
                image_copy[i][j] = zero;
            }
            else
            {
                image_copy[i][j] = image[i - 1][j - 1];
            }
        }
    }

    for (int i = 0; i < height; i++) // pass the image copy to sobel function
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = sobel(i, j, height, width, image_copy); // sobel should return RGB tripple
        }
    }
    return;
}

RGBTRIPLE sobel(int i, int j, int height, int width, RGBTRIPLE image_copy[height + 2][width + 2])
{
    // Take a single pixel (at i,j) and return a single pixel.
    RGBTRIPLE out; // The output RGB triple

    INTTRIPLE zero; // To initialize certain variables
    zero.rgbtRed = 0;
    zero.rgbtBlue = 0;
    zero.rgbtGreen = 0;

    INTTRIPLE Gx[3][3]; // A 3 x 3 triple array to store the Gx sobel values
    INTTRIPLE Gy[3][3]; // A 3 x 3 triple array to store the Gy sobel values

    INTTRIPLE Gx_sum = zero;
    INTTRIPLE Gy_sum = zero;

    // Selecting 9x9 array from image copy to compute Gx, Gy values for
    // a given pixel (i,j) where i varies from 0 to (height -1), j varies from 0 to (width - 1)
    for (int k = i; k < i + 3; k++) // when i = 0, k = (0,1,2), when i = height, k = height, height+1, height+2
    {
        for (int l = j; l < j + 3; l++) // when j = 0, l = (1,2,3), when j = width, l = width = 1, 2, 3
        {
            if (k == i + 1 && l == j + 1) // (1) Center: (i+1, j+1)
            {
                Gx[1][1] = factor(image_copy[k][l], 0);
                Gy[1][1] = factor(image_copy[k][l], 0);
            }
            else if (k == i && l == j) // (2) Left Top (i, j)
            {
                Gx[0][0] = factor(image_copy[k][l], -1);
                Gy[0][0] = factor(image_copy[k][l], -1);
            }
            else if (k == i + 2 && l == j) // (3) Left Bottom (i+2, j)
            {
                Gx[2][0] = factor(image_copy[k][l], -1);
                Gy[2][0] = factor(image_copy[k][l], 1);
            }
            else if (k == i + 1 && l == j) // (4) Left Centre (i+1, j)
            {
                Gx[1][0] = factor(image_copy[k][l], -2);
                Gy[1][0] = factor(image_copy[k][l], 0);
            }
            else if (k == i && l == j + 1) // (5) Centre Top (i, j+1)
            {
                Gx[0][1] = factor(image_copy[k][l], 0);
                Gy[0][1] = factor(image_copy[k][l], -2);
            }
            else if (k == i + 2 && l == j + 1) // (6) Centre Bottom (i+2, j+1)
            {
                Gx[2][1] = factor(image_copy[k][l], 0);
                Gy[2][1] = factor(image_copy[k][l], 2);
            }
            else if (k == i && l == j + 2) // (7) Right Top (i, j+2)
            {
                Gx[0][2] = factor(image_copy[k][l], 1);
                Gy[0][2] = factor(image_copy[k][l], -1);
            }
            else if (k == i + 2 && l == j + 2) // (8) Right Bottom (i+2, j+2)
            {
                Gx[2][2] = factor(image_copy[k][l], 1);
                Gy[2][2] = factor(image_copy[k][l], 1);
            }
            else if (k == i + 1 && l == j + 2) // (9) Right Centre (i+1, j+2)
            {
                Gx[1][2] = factor(image_copy[k][l], 2);
                Gy[1][2] = factor(image_copy[k][l], 0);
            }
        }
    }

    // Compute Gx, Gy Sums
    for (int a = 0; a < 3; a++)
    {
        for (int b = 0; b < 3; b++)
        {
            Gx_sum.rgbtRed += Gx[a][b].rgbtRed;
            Gx_sum.rgbtBlue += Gx[a][b].rgbtBlue;
            Gx_sum.rgbtGreen += Gx[a][b].rgbtGreen;

            Gy_sum.rgbtRed += Gy[a][b].rgbtRed;
            Gy_sum.rgbtBlue += Gy[a][b].rgbtBlue;
            Gy_sum.rgbtGreen += Gy[a][b].rgbtGreen;
        }
    }

    out = suqare_sum(Gx_sum, Gy_sum);

    return out;
}

INTTRIPLE factor(RGBTRIPLE triple, int factor)
{
    INTTRIPLE out;
    out.rgbtRed = (int) factor * triple.rgbtRed;
    out.rgbtBlue = (int) factor * triple.rgbtBlue;
    out.rgbtGreen = (int) factor * triple.rgbtGreen;

    return out;
}

RGBTRIPLE suqare_sum(INTTRIPLE triple_one, INTTRIPLE triple_two) // This func should also cap max value to 255
{
    RGBTRIPLE out;

    out.rgbtRed = max(sqrt(pow(triple_one.rgbtRed, 2) + pow(triple_two.rgbtRed, 2)));
    out.rgbtBlue = max(sqrt(pow(triple_one.rgbtBlue, 2) + pow(triple_two.rgbtBlue, 2)));
    out.rgbtGreen = max(sqrt(pow(triple_one.rgbtGreen, 2) + pow(triple_two.rgbtGreen, 2)));

    return out;
}

int max(double a)
{
    if (a > 255)
    {
        return 255;
    }
    return (int) round(a);
}