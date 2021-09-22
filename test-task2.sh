#!/bin/bash
#Student name:  Aidas Karpavicius
#Student no:    R00171054
#This program performs automatic testing for task2.sh
#Description
#Creates as many folders and files per folder as
#requested, also takes time interval and amount
#of bytes. To randomly increase one of the files
#that where created for testing.
#increase() takes two arguments file and amout of
#bytes that you want to increase its size.
increase(){
    echo "Increasing ${2}"
    for i in `seq ${1}`
    do
        printf "a" >> ${2}
    done
} 
#Promts user for input
echo -n "Please enter how many folders>>> "
read folder_amount
echo -n "Please enter how many files per folder>>> "
read file_amount
echo -n "Please enter delay in sec>>> "
read delay
echo -n "Please enter file increment in bytes>>> "
read bytes
#Creates folders
for f in `seq $folder_amount`
do
    mkdir folder$f
    #creates files in each folder
    for i in `seq $file_amount`
    do
        touch "folder$f/file$i"
    done
done
#perma loop
while true
do
    #selects random folder and random file
    folder=$((1+$RANDOM % ($folder_amount )))
    file=$((1+$RANDOM % ($file_amount )))
    #passes that file as argument to increase
    increase $bytes "folder$folder/file$file"
    clear
    #Displays all folders to see files growing in size
    for folder in `seq $folder_amount`; do
        #ignores tar.gz files so output would be tidy
        ls -l folder$folder -I "*.tar.gz"
    done
    #delays for amount of seconds selected by user
    sleep $delay
done
