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

#Работа с датой последнего запуска скрипта . lastlaunch
#	Формат 2018-11-12 с форматированием в вид 12/Nov/2018

#ll_d=`ls -alt --full-time output* | head -n 1 | awk '{print $6}'
ll_d="2018-11-08"
# Формат 17:56:19
#ll_t=`ls -alt --full-time output* | head -n 1 | awk '{print $7}' | cut -f1 -d"."`
ll_t="04:26:05"
# Замена месяца. Форматирование в вид 12/Nov/2018
ll_ac="`echo $ll_d | awk -F "-" '{print $3,$2,$1}' | sed 's/ /-/g' | {
sed -e '
s/-01-/\/Jan\//
s/-02-/\/Feb\//
s/-03-/\/Mar\//
s/-04-/\/Apr\//
s/-05-/\/May\//
s/-06-/\/Jun\//
s/-07-/\/Jul\//
s/-08-/\/Aug\//
s/-09-/\/Sep\//
s/-10-/\/Oct\//
s/-11-/\/Nov\//
s/-12-/\/Dec\//'
}`:$ll_t"

#echo "ACCESS: $ll_ac"
ll_er="`echo $ll_d | sed 's/-/\//g'` $ll_t"
#echo "ERROR: $ll_er"

dt=`date '+%d-%m-%Y_%H-%M-%S'`

touch output_$dt.txt

# X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта /var/log/nginx/access-4560-c8671a.log	
echo "IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" > output_$dt.txt

awk -v p="$ll_ac" '{if ($4 >= p) print $1}' access-4560-c8671a.log | sort | uniq -c | sort -rn | head -n $1 >> output_$dt.txt

# Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
echo "запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" >> output_$dt.txt
awk -v p="$llac" '{if ($4 >= p) print $7}' access-4560-c8671a.log | sort | uniq -c | sort -nr | head -n $2 >> output_$dt.txt

# все ошибки c момента последнего запуска

echo "все ошибки c момента последнего запуска" >> output_$dt.txt
ll_d=`echo $ll_d | sed 's/-/\//g'`
echo $ll_d
echo $ll_t
awk -v p="$ll_d" -v l="$ll_t" '{if (($1 >= p)&&($2 >= l)) print}' error-4560-d75c02.log >> output_$dt.txt

cat output_$dt.txt
#dt='ls -al lock | awk '{print $8}''
#mailx -s "Stat from nginx server $dt" timur.hisamov@gmail.com < output.txt
