#!/bin/bash
FILE=/etc/sysconfig/keyword
source $FILE

if [ ! -f /var/log/keyword.log ];
then
	touch /var/log/keyword.log
	echo "touch file"
fi

#$1 - file
#$2 - word

search() {
grep $2 $1
}

while true
do
	search $FILE $WORD >> /var/log/keyword.log
	echo "----------0000==NEW_RUN==0000----------" >> /var/log/keyword.log
	sleep 30s
done
