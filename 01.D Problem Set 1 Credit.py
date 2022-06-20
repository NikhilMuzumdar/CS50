# Continue asking for cc no till it's a positive while number 
while True:
  cc = input("Enter the card number:\t")
  try:
    if int(cc) > 0:
      break
  except:
    continue

# Check card validity based on length
if len(cc) in [13,15,16]:
  # Break the string into a list 
  cc_list = [l for l in cc]
  
  # Reverse the list and seperate the ones in odd and even places
  cc_reverse = cc_list[::-1]
  (cc_odd, cc_even) = ([],[])
  for i in range(0, len(cc_reverse)):
    if i%2 == 0:
      cc_odd.append(cc_reverse[i])
    else:
      cc_even.append(cc_reverse[i])
  
  # Initiate temp variables to hold sum values
  (even_sum, odd_sum, check_sum) = (0,0,0)
  # Calculate the odd sum, plain and straight
  odd_sum = sum([int(i) for i in cc_odd])
  # Calculate even sum: multiply digits by 2 & add sum of digits
  cc_even_multiplied = [2*int(i) for i in cc_even]
  for d in cc_even_multiplied:
    if len(str(d)) == 2:
      for l in str(d):
        even_sum += int(l)
    else:
      even_sum += d
  
  # Compute the check_sum
  check_sum = even_sum + odd_sum
  
  # Check if last digit is zero for valid card
  if str(check_sum)[-1] == "0":
    if int(cc[:2]) in [34,37]:
      print("AMEX\n")
    elif int(cc[:2]) in [51, 52, 53, 54, 55]:
      print("MASTERCARD\n")
    elif int(cc[:1]) == 4:
      print("VISA\n")
    else:
      print("INVALID\n")
  else:
    print("INVALID\n")

else:
  print("INVALID\n")
