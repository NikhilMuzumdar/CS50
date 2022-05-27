# CS50
CS50 PSets

# Hello Name 
A program that prompts the user for their name and then prints hello, so-and-so, where so-and-so is their actual name.

# Mario Triangle
Allow the user to decide just how tall the pyramids should be by first prompting them for a positive integer between, say, 1 and 8, inclusive.
Here’s how the program might work if the user inputs 8 when prompted:<br>
![image](https://user-images.githubusercontent.com/65347048/170426800-6147eb28-2246-46a0-b046-570f9d896dea.png)

# Credit 
A credit (or debit) card, of course, is a plastic card with which you can pay for goods and services. Printed on that card is a number that’s also stored in a database somewhere, so that when your card is used to buy something, the creditor knows whom to bill. There are a lot of people with credit cards in this world, so those numbers are pretty long: American Express uses 15-digit numbers, MasterCard uses 16-digit numbers, and Visa uses 13- and 16-digit numbers. And those are decimal numbers (0 through 9), not binary, which means, for instance, that American Express could print as many as 10^15 = 1,000,000,000,000,000 unique cards! (That’s, um, a quadrillion.)

Actually, that’s a bit of an exaggeration, because credit card numbers actually have some structure to them. All American Express numbers start with 34 or 37; most MasterCard numbers start with 51, 52, 53, 54, or 55 (they also have some other potential starting numbers which we won’t concern ourselves with for this problem); and all Visa numbers start with 4. But credit card numbers also have a “checksum” built into them, a mathematical relationship between at least one number and others. That checksum enables computers (or humans who like math) to detect typos (e.g., transpositions), if not fraudulent numbers, without having to query a database, which can be slow. Of course, a dishonest mathematician could certainly craft a fake number that nonetheless respects the mathematical constraint, so a database lookup is still necessary for more rigorous checks.<br>

<h3>Luhn’s Algorithm</h3>
So what’s the secret formula? Well, most cards use an algorithm invented by Hans Peter Luhn of IBM. According to Luhn’s algorithm, you can determine if a credit card number is (syntactically) valid as follows:<br>

Multiply every other digit by 2, starting with the number’s second-to-last digit, and then add those products’ digits together.<br>
Add the sum to the sum of the digits that weren’t multiplied by 2.<br>
If the total’s last digit is 0 (or, put more formally, if the total modulo 10 is congruent to 0), the number is valid!<br>
That’s kind of confusing, so let’s try an example with David’s Visa: 4003600000000014.<br>

For the sake of discussion, let’s first underline every other digit, starting with the number’s second-to-last digit:
4003600000000014<br>
Okay, let’s multiply each of the underlined digits by 2:<br>
1•2 + 0•2 + 0•2 + 0•2 + 0•2 + 6•2 + 0•2 + 4•2<br>
That gives us:
2 + 0 + 0 + 0 + 0 + 12 + 0 + 8<br>
Now let’s add those products’ digits (i.e., not the products themselves) together:
2 + 0 + 0 + 0 + 0 + 1 + 2 + 0 + 8 = 13<br>
Now let’s add that sum (13) to the sum of the digits that weren’t multiplied by 2 (starting from the end):<br>
13 + 4 + 0 + 0 + 0 + 0 + 0 + 3 + 0 = 20

Yup, the last digit in that sum (20) is a 0, so David’s card is legit!
So, validating credit card numbers isn’t hard, but it does get a bit tedious by hand. Let’s write a program.

<h3>Implementation Details</h3>
In the file called credit.c in the credit directory, write a program that prompts the user for a credit card number and then reports (via printf) whether it is a valid American Express, MasterCard, or Visa card number, per the definitions of each’s format herein. So that we can automate some tests of your code, we ask that your program’s last line of output be AMEX\n or MASTERCARD\n or VISA\n or INVALID\n, nothing more, nothing less. For simplicity, you may assume that the user’s input will be entirely numeric (i.e., devoid of hyphens, as might be printed on an actual card) and that it won’t have leading zeroes. But do not assume that the user’s input will fit in an int! Best to use get_long from CS50’s library to get users’ input. (Why?)

# Scrabble
In the game of Scrabble, players create words to score points, and the number of points is the sum of the point values of each letter in the word.<br>
![image](https://user-images.githubusercontent.com/65347048/170630110-e86fd5c6-1ad0-4b32-8871-67204545c814.png)
<br>
For example, if we wanted to score the word Code, we would note that in general Scrabble rules, the C is worth 3 points, the o is worth 1 point, the d is worth 2 points, and the e is worth 1 point. Summing these, we get that Code is worth 3 + 1 + 2 + 1 = 7 points.<br>

<h3>Implementation Details</h3>
Complete the implementation of scrabble.c, such that it determines the winner of a short scrabble-like game, where two players each enter their word, and the higher scoring player wins.<br>

Notice that we’ve stored the point values of each letter of the alphabet in an integer array named POINTS.<br>
For example, A or a is worth 1 point (represented by POINTS[0]), B or b is worth 3 points (represented by POINTS[1]), etc.<br>
Notice that we’ve created a prototype for a helper function called compute_score() that takes a string as input and returns an int. Whenever we would like to assign point values to a particular word, we can call this function. Note that this prototype is required for C to know that compute_score() exists later in the program.<br>
In main(), the program prompts the two players for their words using the get_string() function. These values are stored inside variables named word1 and word2.<br>
In compute_score(), your program should compute, using the POINTS array, and return the score for the string argument. Characters that are not letters should be given zero points, and uppercase and lowercase letters should be given the same point values.<br>
For example, ! is worth 0 points while A and a are both worth 1 point.<br>
Though Scrabble rules normally require that a word be in the dictionary, no need to check for that in this problem!<br>
In main(), your program should print, depending on the players’ scores, Player 1 wins!, Player 2 wins!, or Tie!.<br>
