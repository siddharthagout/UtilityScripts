#!/bin/bash
#This script sends text mentioned in particular file to mentioned receipient.

dateNow=`date +%F`
logFile="./.genrep.log"
repoFile="/path/to/your/file" #Any file from which you want to send content
mailToAdd="your_email@gmail.com"

#Check if log file is present in for every execution
checkLogifile () {
	if [ -f $logFile ]
	then
		echo "`date`	-	logfile present" >> $logFile
	else
 		echo "`date`	-	Creating logfile" > $logFile
	fi
}


#Create report on based on given file input
generateReport () {
	echo "`date`	-	Generating test report for time `date +%c` " >> $logFile
	cat $repoFile | mail -s "Task Reports for $dateNow" $mailToAdd # here provide more emails if require using space separated
	echo "`date`	-	Generated report is as followed: " >> $logFile
	echo "****************************************************************************************************"  >> $logFile
	cat $repoFile >> $logFile
	echo -e
	echo "****************************************************************************************************"  >> $logFile
	echo "`date`	-	Report Sent at `date +%c` " >> $logFile
}

#Execute generate report only on Weekdays
checkWeekDay () {

	today=`date +%c | cut -d" " -f1`
	
	if [ $today == "Monday" ] || [ $today == "Tuesday" ] || [ $today == "Wednesday" ] || [ $today == "Thursday" ] || [ $today == "Friday" ]; then
		checkLogifile
		generateReport
	else
		echo "I am on weekend off" >> $logFile
	fi
}

checkWeekDay

