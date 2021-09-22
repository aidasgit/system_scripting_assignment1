#!/bin/bash
#Student name:  Aidas Karpavicius
#Student no:    R00171054
#Script Description
#This script reads file that is passed as argument
#and creates users that where in a file one user per line.
#all created users are stored in a array created_users
#if user already exits it will be skipped.

#Global created_users array that stores users that will be created by this script
created_users=()
#This function outputs as many lines as there are entries in created_users 
#of the end of /etc/passwd
#and display home directory
confirmation(){
    printf "\n Confirmation info \n"
    echo "End of /etc/passwd"
    tail -n ${#created_users[@]} /etc/passwd
    echo "ls -l of home directory"
    ls -l /home
}
#checking if file parameter was passed
if [ $# -ge 1 ]
then
    #making sure parameter passed is actual file in current dir
    if [ -f ${1} ]
    then
        file=${1}
    else
        echo "Argument must be a valid file"
        exit 1
    fi
else
    echo "You need provide a file, with user names in it..."
    echo "Usage ./task3.sh {file.txt}"
fi
#checking if script ran as root if not displaying error msg
if [[ $EUID -ne 0 ]]
then
    echo "This script must be run as root"
    exit 1
fi
#reading each line of the passed file and assigning its value to user
for user in `cat $file`
do
    #checking /etc/passwd using grep -c ( to count ) 
    #if user exits it will return 1
    if [ `grep -c "$user:" /etc/passwd` == 1 ]
    then
        echo "$user - already exits, so it can't be created.."
    else
    #otherwise displaying msg that user is created and creating user -m for making sure home directory will be also created
        echo "$user - created."
        useradd -m $user
        #adding new user name to created user array
        created_users=("${created_users[@]}" "$user")
    fi
done 
#displaying /etc/passwd and home directory
confirmation
#printing out names of users to be deleted
echo "Users to be deleted:"
#iterating through the aray created_users
for user in ${created_users[@]}
do
    #printing each value
    echo $user
done
#prompting user does he want to delete the users
echo -n "Would you like to delete these users(y/n)>> "
read choice
#if choice is reg expresion [yY] y or Y+es and * for anything after
if [[ "$choice" =~ [yY](es)* ]]
then
    #if user prompt was positive cycle through all created users
    for user in ${created_users[@]}
    do
        #deleteing user and its home directory and getting rid of that error msg about email spool
        userdel -r $user 2>/dev/null
        #displaying user name and that it was deleted
        echo "$user - deleted"
    done
else
    #otherwise telling that there was no changes made
    echo "No changes were made"
fi
#outputing /etc/passwd and /home
confirmation
