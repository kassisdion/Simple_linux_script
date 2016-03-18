#! /bin/sh
# Write a Bash shell script program that takes two integer arguments.
# assumed to be greater than the first.
# The second argument is
# The output of the program is a counting of numbers
# beginning at the first number and ending with the second number.

SUCCESS=1
FAIL=0

#the 2 number will be passed as parameters
_counterLoop() {
    var=$1

    while [ $var -le $2 ]
    do
	echo -n "$var "
	var=$(($var + 1))
    done
    echo ""
    return $SUCCESS
}
#check if $1 is a number
_isNumber() {
    if echo $1 | egrep -q '^[0-9]+$'
    then
	return $SUCCESS
    else
	return $FAIL
    fi
}

###
# Main body of script starts here
###
#check the number of parameter
if [ "$#" -ne 2 ]
then
    echo "usage: ./counter.sh number1 number2"
    exit $FAIL
fi

#check if parameter are numbers
_isNumber $1
return_val=$?
if [ $return_val -eq $FAIL ]
then
    echo "$1 is not a number"
    exit $FAIL
fi

#check format of $2
_isNumber $2
return_val=$?
if [ $return_val -eq $FAIL ]
then
    echo "$1 is not a number"
    exit $FAIL
fi

#display the input
echo "Welcom to counter :)"
echo "You have choosen $1 and $2"
echo ""

#display the response
_counterLoop $1 $2
