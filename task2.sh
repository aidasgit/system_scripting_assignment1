#!/bin/bash

#Student name: 	Aidas Karpavicius
#Studen no:	R00171054

#Program description
#This script uses backing_up function that does most of the work in this script (description below). Multiple directories can be passed as argument all directories will be monitored recursively and backed up indefinetly or until process is killed.

#Functions
#This function uses find to get a list of files that are
#over 4kb and their name not log.txt and also not ending
#.tar.gz. After it itrerates through all the files that
#matches the criteria. saves its path and file name then
#displays info msg that file is being backed up
#creates a backup with a formated time stamp
#deletes the file. and creates empty file with the same name
backing_up(){
    for file in $(find $folders -size +4k ! -name $log ! -name "*.tar.gz")
    do
        #extracting path and file name
        path=`dirname $file`
        file_n=`basename $file`
        #Displaying info msg  
        echo "Backing up file $file"
        #making a new entry in a log file
        echo "`date` $file" >> $path/$log
        #using -C option here so there would be no relative path from where script is executed, just a file name.
        tar cfz "$path/`date +"%T-%d-%m-%Y-"`$file_n.tar.gz" -C $path $file_n
        #deleting the file
        rm $file
        #creating empty file with the same name
        touch $file
    done
}

#Globals
#file name that will be used for logs
log="log.txt"

#if no parameters received display usage
#and exit program
if [ $# -ge 1 ]
then
	folders=$*
else
	echo "Please specify the folder or folders you would like to monitor"
	exit;
fi
#perma loop to monitor a folder
while true
do
    #call of a funtion that will back up and delete files
    backing_up
    #wait for 1 sec to reserve cpu
    sleep 1
done

