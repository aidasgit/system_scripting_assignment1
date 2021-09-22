#!/bin/bash
#Student name: Aidas Karpavicius
#Student no: 	R00171054

#Program descripion
#There are two functions that are very similar, to perform
#math operations on two arguments ( + , * )
#And decision function checks arguments 
#if none provided displays error msg and do nothing
#if second argument is multiple of 5
#uses multiplication()
#else uses addition()


#Functions

#addition() adds two numbers, and displays result
addition(){
	echo "$1 + $2 = $(( $1 + $2 ))"
}

#multiplication() multiplies two numbers, and displays result
multiplication(){
	echo "$1 * $2 = $(($1 * $2))"
}

#decision() checks if second argument multiple of 5
#if it is then two arguments are multiplied
#if not then two argumets are added
#also if no argumetns suplied displays error msg
#and terminates fuction execution
decision(){
	if (( $# != 2 ))
	then
		echo "You must provide 2 parameters, for script to work properly"
		return;
	fi
	if (($2 % 5 == 0))
       	then
		multiplication $1 $2;
	else
		addition $1 $2;
	fi
}	

#Program begins
#for loop repeats commands 4 times
for i in {1..4}
do
	#display which iteration is being executed
	echo "Operation no: $i"
	#Promts for two numbers
	echo -n "Please enter 1st digit >>> "; read num1;
	echo -n "Please enter 2st digit >>> "; read num2;

	#Passes user input to decision function
	decision $num1 $num2;
done

