#! /bin/sh
# Write a number guessing game in Bash scripts.
# The user has 5 chances to guess a random
# number between 1 and 10. The game will only accept valid numerical numbers between 1 and
# 10. Invalid input guesses will count towards the 5 guesses

SUCCESS=1
FAIL=0

MAX_TRY=5

#The number to find will be passed as parameter
_gameLoop() {
    
    counter=0
    while [ $counter -le $MAX_TRY ]
    do
	#get the response
	echo "Try $counter"
	echo -n ":-> "
	read answer

	#check the reponse format
	if echo $answer | egrep -q "^[0-9]+$"
	then
	    
	    #check answer value
	    if [ $answer -eq $1 ]
	    then
		echo "Well played (the number was $1) :)"
		return $SUCCESS
	    elif [ $answer -lt $1 ]
	    then
		 echo "Try a bigger number :)"
	    elif [ $answer -gt $1 ]
	    then
		 echo "Try a smaller number :)"
	    fi
	       
	    #increment counter
	    counter=$(($counter + 1))
	else
	    echo "$answer is not a number, try again !"
	fi    
	echo ""
    done
    return $SUCCESS
}

###
# Main Body of script starts here
###
echo "Welcom to the min_max game."
echo "Your goal is to find a number beetwen 1 and 10"
echo ""
echo "You whill have 5 try to find out the number"
echo ""
echo "Let's play !"
echo ""

_gameLoop `shuf -i 0-10 -n 1`
