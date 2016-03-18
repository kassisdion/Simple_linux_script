#! /bin/sh
# Write an advanced phonebook scripts. Phonebook has at least three fields : name, e-mail
# address, and phone number. It provides following functions: insert, modify, delete, search, and
# list. Phone numbers should be stored in the alphabetical order of name.

BOOK="phonebook.txt"

FAIL=0
SUCCESS=1

###
# Insert a user
##
_insert() {
    echo -n "Name of the person ? "
    read name

    echo -n "Street address ? "
    read street_address

    echo -n "City ? "
    read city

    echo -n "State ? "
    read state

    echo -n "Zip code ? "
    read zip_code
        
    echo -n "Phone number ? "
    read phone_number

    echo -n "Email ? "
    read email
    
    #Check is there is no mystake
    echo "Should I add this contact :"
    echo " $name \n $street_address \n $city \n $state \n $zip_code \n $phone_number \n $email"
    _getUserAgreement
    return_val=$?
    if [ $return_val -eq $SUCCESS ]
    then
	#write value to the book
	echo "$name $street_address $city $state $zip_code $phone_number $email" >> $BOOK
	echo "$name; $street_address; $city; $state; $zip_code; $phone_number; $email"
	echo "Has been added"
	sleep 3
	return $SUCCESS
    else
	echo "User not added"
	sleep 3
	return $FAIL
    fi
}

###
# Modify a user
##
_modify() {
    echo "What is the id of the user do you want to edit ?"
    echo "You can found it by using the 'list' function"
    read userID

    #ask for vérification
    echo "Do you want to remove this user : "
    echo `nl --number-separator=": " $BOOK | grep "$userID: "`

    _getUserAgreement
    return_val=$?
    if [ $return_val -eq $SUCCESS ]
    then
	_insert
	return_val=$?
	if [ $return_val -eq $SUCCESS ]
	then
	    _deleteLineFromBook $userID
	    return $SUCCESS
	fi
    fi
    return $FAIL
}

###
# Delete a user
##
_delete() {
    echo "What is the id of the user do you want to delete ?"
    echo "You can found it by using the 'list' function"

    read userID
    echo ""
    
    echo "Do you want to delete this user : "
    echo `nl --number-separator=": " $BOOK | grep "$userID: "`
    _getUserAgreement
    if [ $? ]
    then
	_deleteLineFromBook $userID
	echo "User successfully deleted"
	sleep 3
	return $SUCCESS
    else
	echo "User not delete"
	sleep 3
	return $FAIL
    fi
}

###
# Search for a user
##
_search() {
    echo "What are you seeking ? (type a keyword) : "
    read find
    grep -i $find $BOOK | less
    return $SUCCESS
}

###
# List all users
##
_list() {
    nl --number-separator=" :-> " $BOOK | less
    return $SUCESS
}

###
# Main function
###
_phoneBook() {
    _displayMainMessage
    read action
    echo ""

    #convert string to lower case
    lowerAction=`echo $action | tr "A-Z" "a-z"`;
    
    # parse the response
    if [ "$lowerAction" = "1" ] || [ "$lowerAction" = "insert" ]
    then
	_insert
    elif [ "$lowerAction" = "2" ] || [ "$lowerAction" = "modify" ]
    then
	_modify
    elif [ "$lowerAction" = "3" ] || [ "$lowerAction" = "delete" ]
    then
	_delete
    elif [ "$lowerAction" = "4" ] || [ "$lowerAction" = "search" ]
    then
	_search
    elif [ "$lowerAction" = "5" ] || [ "$lowerAction" = "list" ]
    then
	_list
    elif [ "$lowerAction" = "6" ] || [ "$lowerAction" = "exit" ]
    then
	return $FAIL
    else
	echo "I do not understand the command."
    fi
    return $SUCCESS
}

###
# Utils
##
_displayMainMessage() {
    tput clear
    
    echo "Welcome to PhoneBook :)"
    echo ""

    echo "What do you want to do ?"
    echo "1) Insert"
    echo "2) Modify"
    echo "3) Delete"
    echo "4) Search"
    echo "5) List"
    echo "6) Exit"
    echo ""
}

_getUserAgreement() {
    #ask for confirmation
    echo "y/n ?"
    read answer

    #convert to lowerCase
    lowerAnswer=`echo $answer | tr "A-Z" "a-z"`;
    
    if [ "$lowerAnswer" = "y" ]
    then
	return $SUCCESS
    else
	return $FAIL
    fi
}

_deleteLineFromBook() {
    lineNumber=$1

    mv $BOOK tmp_book.txt
    nl --number-separator=": " tmp_book.txt | grep -v "$lineNumber: " | awk -F: '{print $2}' |  tee $BOOK >&- 2>&-
    return $SUCCESS
}

###
# Main body of script starts here
###
RUN=$SUCCESS
while [ $RUN -eq $SUCCESS ]
do
    _phoneBook
    RUN=$?
done
