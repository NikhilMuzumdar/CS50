# CS50
CS50 PSets

# 00. Hello Name 
A program that prompts the user for their name and then prints hello, so-and-so, where so-and-so is their actual name.

# 01. Mario Triangle
Allow the user to decide just how tall the pyramids should be by first prompting them for a positive integer between, say, 1 and 8, inclusive.
Here’s how the program might work if the user inputs 8 when prompted:<br>
![image](https://user-images.githubusercontent.com/65347048/170426800-6147eb28-2246-46a0-b046-570f9d896dea.png)

# 02. Credit 
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

# 03. Scrabble
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

# 04. Readability
According to Scholastic, E.B. White’s Charlotte’s Web is between a second- and fourth-grade reading level, and Lois Lowry’s The Giver is between an eighth- and twelfth-grade reading level. What does it mean, though, for a book to be at a particular reading level?<br>
Well, in many cases, a human expert might read a book and make a decision on the grade (i.e., year in school) for which they think the book is most appropriate. But an algorithm could likely figure that out too!<br>
So what sorts of traits are characteristic of higher reading levels? Well, longer words probably correlate with higher reading levels. Likewise, longer sentences probably correlate with higher reading levels, too.<br>

A number of “readability tests” have been developed over the years that define formulas for computing the reading level of a text. One such readability test is the Coleman-Liau index. The Coleman-Liau index of a text is designed to output that (U.S.) grade level that is needed to understand some text.<br>
The formula is:<br>
<h3>index = 0.0588 * L - 0.296 * S - 15.8</h3><br>
where L is the average number of letters per 100 words in the text, and S is the average number of sentences per 100 words in the text.<br>

Let’s write a program called readability that takes a text and determines its reading level. For example, if user types in a line of text from Dr. Seuss, the program should behave as follows:<br>
<h5>$ ./readability<br>
Text: Congratulations! Today is your day. You're off to Great Places! You're off and away!<br>
Grade 3</h5><br>
  
The text the user inputted has 65 letters, 4 sentences, and 14 words. 65 letters per 14 words is an average of about 464.29 letters per 100 words (because 65 / 14 * 100 = 464.29). And 4 sentences per 14 words is an average of about 28.57 sentences per 100 words (because 4 / 14 * 100 = 28.57). Plugged into the Coleman-Liau formula, and rounded to the nearest integer, we get an answer of 3 (because 0.0588 * 464.29 - 0.296 * 28.57 - 15.8 = 3): so this passage is at a third-grade reading level.

Let’s try another one:<br>

<h5>$ ./readability<br>
Text: Harry Potter was a highly unusual boy in many ways. For one thing, he hated the summer holidays more than any other time of year. For another, he really wanted to do his homework, but was forced to do it in secret, in the dead of the night. And he also happened to be a wizard.<br>
Grade 5</h5>

This text has 214 letters, 4 sentences, and 56 words. That comes out to about 382.14 letters per 100 words, and 7.14 sentences per 100 words. Plugged into the Coleman-Liau formula, we get a fifth-grade reading level.<br>

As the average number of letters and words per sentence increases, the Coleman-Liau index gives the text a higher reading level. If you were to take this paragraph, for instance, which has longer words and sentences than either of the prior two examples, the formula would give the text an twelfth-grade reading level.<br>

<h5>$ ./readability<br>
Text: As the average number of letters and words per sentence increases, the Coleman-Liau index gives the text a higher reading level. If you were to take this paragraph, for instance, which has longer words and sentences than either of the prior two examples, the formula would give the text an twelfth-grade reading level.<br>
Grade 12</h5><br>

<h3>Implementation Details</h3>
<ol>
<li>Implement your program in a file called readability.c in a directory called readability.</li>
<li>Your program must prompt the user for a string of text using get_string.</li>
<li>Your program should count the number of letters, words, and sentences in the text. You may assume that a letter is any lowercase character from a to z or any uppercase character from A to Z, any sequence of characters separated by spaces should count as a word, and that any occurrence of a period, exclamation point, or question mark indicates the end of a sentence.</li>
<li>Your program should print as output "Grade X" where X is the grade level computed by the Coleman-Liau formula, rounded to the nearest integer.</li>
<li>If the resulting index number is 16 or higher (equivalent to or greater than a senior undergraduate reading level), your program should output "Grade 16+" instead of giving the exact index number. If the index number is less than 1, your program should output "Before Grade 1".</li></ol>

# 05. Substitution
In a substitution cipher, we “encrypt” (i.e., conceal in a reversible way) a message by replacing every letter with another letter. To do so, we use a key: in this case, a mapping of each of the letters of the alphabet to the letter it should correspond to when we encrypt it. To “decrypt” the message, the receiver of the message would need to know the key, so that they can reverse the process: translating the encrypt text (generally called ciphertext) back into the original message (generally called plaintext).<br>

A key, for example, might be the string NQXPOMAFTRHLZGECYJIUWSKDVB. <br>This 26-character key means that A (the first letter of the alphabet) should be converted into N (the first character of the key), B (the second letter of the alphabet) should be converted into Q (the second character of the key), and so forth.<br>

A message like HELLO, then, would be encrypted as FOLLE, replacing each of the letters according to the mapping determined by the key.<br>

Let’s write a program called substitution that enables you to encrypt messages using a substitution cipher. At the time the user executes the program, they should decide, by providing a command-line argument, on what the key should be in the secret message they’ll provide at runtime.

<h3>Implementation Details</h3>
<h4>Design and implement a program, substitution, that encrypts messages using a substitution cipher.</h4>

Implement your program in a file called substitution.c in a directory called substitution.
<ol>
<li>Your program must accept a single command-line argument, the key to use for the substitution. The key itself should be case-insensitive, so whether any character in the key is uppercase or lowercase should not affect the behavior of your program.</li>
<li>If your program is executed without any command-line arguments or with more than one command-line argument, your program should print an error message of your choice (with printf) and return from main a value of 1 (which tends to signify an error) immediately.</li>
<li>If the key is invalid (as by not containing 26 characters, containing any character that is not an alphabetic character, or not containing each letter exactly once), your program should print an error message of your choice (with printf) and return from main a value of 1 immediately.</li>
<li>Your program must output plaintext: (without a newline) and then prompt the user for a string of plaintext (using get_string).</li>
<li>Your program must output ciphertext: (without a newline) followed by the plaintext’s corresponding ciphertext, with each alphabetical character in the plaintext substituted for the corresponding character in the ciphertext; non-alphabetical characters should be outputted unchanged.</li>
<li>Your program must preserve case: capitalized letters must remain capitalized letters; lowercase letters must remain lowercase letters.</li>
<li>After outputting ciphertext, you should print a newline. Your program should then exit by returning 0 from main.</li>
</ol>
