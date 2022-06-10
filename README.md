# CS50
CS50 PSets

# 00. Hello Name 
https://cs50.harvard.edu/x/2022/psets/1/hello/<br>
A program that prompts the user for their name and then prints hello, so-and-so, where so-and-so is their actual name.<br>

# 01. Mario Triangle
https://cs50.harvard.edu/x/2022/psets/1/mario/more/<br>
A program that prints a traingle from the game mario based on validated height input by user.<br>

# 02. Credit
https://cs50.harvard.edu/x/2022/psets/1/credit/<br>
Uses Luhn’s Algorithm to validate a given credit card number.<br>

# 02.A Cash (Optional)
https://cs50.harvard.edu/x/2022/psets/1/cash/<br>
Calculates the least number of coins to be given to return a given change.

# 03. Scrabble
https://scrabble.hasbro.com/en-us/rules<br>
Takes name from 2 players and returns the winner after calculating points assigned to each character.<br>

# 04. Readability
https://cs50.harvard.edu/x/2022/psets/2/readability/
Uses Coleman-Liau index to output that (U.S.) grade level that is needed to understand some text.<br>

# 05. Substitution
https://cs50.harvard.edu/x/2022/psets/2/substitution/<br>
Takes a encryption 26 letter key, Example NQXPOMAFTRHLZGECYJIUWSKDVB to encryypt the input.<br>
Implimentation using command line argument.<br>

# 05.A Caesar Cipher (Optional)
https://cs50.harvard.edu/x/2022/psets/2/caesar/<br>
Takes a key to shift the places of letters by that many places. Non alphabets remain unchanged.<br>
Implimentation using command line argument.<br>

# 06. Lab Assignment
https://cs50.harvard.edu/x/2022/labs/3/<br>
Solution:<br>
<table cellspacing=1 border=1>
					<tr>
						<td style=min-width:50px>Time Taken</td>
						<td style=min-width:50px>Sorted</td>
						<td style=min-width:50px></td>
						<td style=min-width:50px>Random</td>
						<td style=min-width:50px></td>
						<td style=min-width:50px>Reversed</td>
						<td style=min-width:50px></td>
					</tr>
					<tr><td style=min-width:50px>Dataset--></td>
					<td style=min-width:50px>10k </td>
					<td style=min-width:50px>50k</td>
					<td style=min-width:50px>10k </td>
					<td style=min-width:50px>50k</td>
					<td style=min-width:50px>10k </td>
					<td style=min-width:50px>50k</td>
				</tr>
				<tr>
					<td style=min-width:50px>Sort 1</td>
					<td style=min-width:50px>0.085</td>
					<td style=min-width:50px>1.644</td>
					<td style=min-width:50px>0.296</td>
					<td style=min-width:50px>9.642</td>
					<td style=min-width:50px>0.308</td>
					<td style=min-width:50px>6.663</td>
				</tr>
				<tr>
					<td style=min-width:50px>Sort 2</td>
					<td style=min-width:50px>0.070</td>
					<td style=min-width:50px>1.455</td>
					<td style=min-width:50px>0.062</td>
					<td style=min-width:50px>1.796</td>
					<td style=min-width:50px>0.065</td>
					<td style=min-width:50px>1.955</td>
				</tr>
				<tr>
					<td style=min-width:50px>Sort 3</td>
					<td style=min-width:50px>0.216</td>
					<td style=min-width:50px>3.534</td>
					<td style=min-width:50px>0.158</td>
					<td style=min-width:50px>4.978</td>
					<td style=min-width:50px>0.185</td>
					<td style=min-width:50px>4.619</td>
				</tr>
				<tr>
					<td style=min-width:50px></td>
					<td style=min-width:50px></td>
					<td style=min-width:50px></td>
					<td style=min-width:50px></td>
					<td style=min-width:50px></td>
					<td style=min-width:50px></td>
					<td style=min-width:50px></td>
				</tr>
				<tr>
					<td style=min-width:50px>Time %</td>
					<td style=min-width:50px>Sorted</td>
					<td style=min-width:50px></td>
					<td style=min-width:50px>Random</td>
					<td style=min-width:50px></td>
					<td style=min-width:50px>Reversed</td>
					<td style=min-width:50px></td>
				</tr>
				<tr>
					<td style=min-width:50px>Sort 1</td>
					<td style=min-width:50px>23.00</td>
					<td style=min-width:50px>25.00</td>
					<td style=min-width:50px>57.00</td>
					<td style=min-width:50px>59.00</td>
					<td style=min-width:50px>55.00</td>
					<td style=min-width:50px>50.00</td>
				</tr>
				<tr>
					<td style=min-width:50px>Sort 2</td>
					<td style=min-width:50px>19.00</td>
					<td style=min-width:50px>22.00</td>
					<td style=min-width:50px>12.00</td>
					<td style=min-width:50px>11.00</td>
					<td style=min-width:50px>12.00</td>
					<td style=min-width:50px>15.00</td>
				</tr>
				<tr>
					<td style=min-width:50px>Sort 3</td>
					<td style=min-width:50px>58.00</td>
					<td style=min-width:50px>53.00</td>
					<td style=min-width:50px>31.00</td>
					<td style=min-width:50px>30.00</td>
					<td style=min-width:50px>33.00</td>
					<td style=min-width:50px>35.00</td>
				</tr>
			</table> <br>
<h5> Observations </h5>
<ul>
  <li> Sort1: Bubble Sort (Significant difference between Random & Sorted Performance (O and Ω Vary))</li>
  <li> Sort2: Merge Sort (Appears to perform better overall indicating the superior Merge Sort) </li>
  <li> Sort3: Selection Sort (Takes longer time even on Sorted Data Set)</li>
</ul>

# 06 Plurality (Election)
https://cs50.harvard.edu/x/2022/psets/3/plurality/<br>
Perhaps the simplest way to hold an election, though, is via a method commonly known as the “plurality vote” (also known as “first-past-the-post” or “winner take all”). In the plurality vote, every voter gets to vote for one candidate. At the end of the election, whichever candidate has the greatest number of votes is declared the winner of the election.<br>

# 07 Runoff (Election)
https://cs50.harvard.edu/x/2022/psets/3/runoff/<br>
A voting system known as a ranked-choice voting system where voters can vote for more than one candidate.
<br>Instead of just voting for their top choice, they can rank the candidates in order of preference. 

# 08. Lab Assignment
https://cs50.harvard.edu/x/2022/labs/4/<br>
Modify volume of a wave file by manipulating the bit files. 

# 09. Filter-less
https://cs50.harvard.edu/x/2022/psets/4/filter/less/<br>
Implement a program that applies filters to BMPs<br>


