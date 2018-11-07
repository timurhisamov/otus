#!/bin/bash

dt=`date '+%Y-%m-%d_%H-%M-%S'`

touch output_$dt.txt

# X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта /var/log/nginx/access.log	
echo "IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" > output_$dt.txt
awk '{print $1}' access.log | sort | uniq -c | sort -rn | sed -n "1,${1}p" >> output_$dt.txt

# Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
echo "запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" >> output_$dt.txt
awk '{print $7}' access.log | sort | uniq -c | sort -nr | head -n $2 >> output_$dt.txt


#dt='ls -al lock | awk '{print $8}''
#mailx -s "Stat from nginx server $dt" timur.hisamov@gmail.com < output.txt
