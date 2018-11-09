#!/bin/bash

P1=$1
function printUsage() {
    cat <<EOF

monitoring
    $scriptName [name] [-h] [X] [Y]
    Скрипт ищет лог-файлы анализирует их на ошибки и отправляет отчет в виде html странички на почту.
    Для удобства использования пользователь имеет возможность задать параметры работы

    [dir]
        Директория для анализа.

    -h
        Подсказка
    [X]
    	Количество IP адресов с наибольшим количеством запросов

    [Y]
    	Количество запрашиваемых IP адресов с наибольшим количеством запросов


	
EOF
}
if [ "$P1" = "-h" ]; then
            printUsage;
            exit
fi


dt=`date '+%d-%m-%Y:%H-%M-%S'`

touch output_$dt.txt

# X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта /var/log/nginx/access-4560-c8671a.log	
echo "IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" > output_$dt.txt
awk '{print $1}' access-4560-c8671a.log | sort | uniq -c | sort -rn | sed -n "1,${1}p" >> output_$dt.txt

# Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
echo "запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" >> output_$dt.txt
awk '{print $7}' access-4560-c8671a.log | sort | uniq -c | sort -nr | head -n $2 >> output_$dt.txt

# все ошибки c момента последнего запуска

echo "все ошибки c момента последнего запуска"
awk '($9 !~ /200|304/)' access-4560-c8671a.log | awk '{print $9,$7,$11}' | sort | uniq -c | sort -r -n | head -n 70

cat output_$dt.txt
#dt='ls -al lock | awk '{print $8}''
#mailx -s "Stat from nginx server $dt" timur.hisamov@gmail.com < output.txt
