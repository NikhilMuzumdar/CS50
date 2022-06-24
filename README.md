# CS50
CS50 PSets

# Problem Set 1 - Hello
https://cs50.harvard.edu/x/2022/psets/1/hello/<br>
A program that prompts the user for their name and then prints hello, so-and-so, where so-and-so is their actual name.<br>

# Problem Set 1 - Mario-less
https://cs50.harvard.edu/x/2022/psets/1/mario/less/<br>

# Problem Set 1 - Mario-more
https://cs50.harvard.edu/x/2022/psets/1/mario/more/<br>

# Problem Set 1 - Cash
https://cs50.harvard.edu/x/2022/psets/1/cash/<br>


# Problem Set 1 - Credit
https://cs50.harvard.edu/x/2022/psets/1/credit/<br>

# Lab 2 Scrabble
https://cs50.harvard.edu/x/2022/labs/2/<br>

# Problem Set 2 - Readability
https://cs50.harvard.edu/x/2022/psets/2/readability/<br>

# Problem Set 2 - Caesar
https://cs50.harvard.edu/x/2022/psets/2/caesar/<br>

# Problem Set 2 - Substitution
https://cs50.harvard.edu/x/2022/psets/2/substitution/<br>

# Lab 3 Sort
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

