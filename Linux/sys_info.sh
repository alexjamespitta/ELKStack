#!/bin/bash

#variables
now=$(date)
name=$(uname)
IP=$(ifconfig docker0 | grep inet | awk '{print $2}')
hostname=$(hostname)
exec=$(find /home -type f -perm 777 2> /dev/null)
proc=$(ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head -11)
files=$(
	'/etc/passwd'
	'/etc/shadow'
	)
output=$HOME/research/sys_info.txt

#check for research folder, if doesnt exist, create
if [ ! -d $HOME/research ]
then
mkdir $HOME/research
fi

#check for output file, if exists remove 
if [ -f $output ] 
then
   rm $output
fi

echo "System Audit" > $output
#date
echo "$now" >> $output
echo "" >> $output
#print machine info
echo "This system is running on $name" >> $output
echo "The machine type is $MACHTYPE" >> $output
#print IP address
echo "The IP address is $IP" >> $output
#print hostname
echo "The host is $hostname" >> $output
echo "" >> $output
#print current user
echo "Current user:" >> $output
whoami >> $output
echo "" >>$output
#print CPU usage
echo "CPU Info:" >> $output
lscpu | grep CPU >> $output
echo "" >> $output
#print disk usage
echo "Disk Usage" >> $output
df -H | head -2 >> $output
echo "" >> $output

#print executable files
echo "Permission 777 files" >> $output
echo "$exec" >> $output
echo "" >> $output
#print top 10 running processes
echo "Top 10 processes" >> $output
echo "$proc" >> $output
echo "" >> $output
#print file permissions
echo "File Permissions for select /etc files:" >> $output
for file in ${files[@]}
do
	ls -l 2>/dev/null $file >> $output
done
