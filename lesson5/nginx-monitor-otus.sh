#!/bin/bash


###

# Шел скрипт позволяет проанализировать логи nginx и отправить результаты на почту

# version 0.1

###


P1=$1
function printUsage() {
    cat <<EOF

nginx-monitor-otus
    $scriptName [-h] [X] [Y]
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


@OTUS-2018
	
EOF
}
if [ "$P1" = "-h" ]; then
            printUsage;
            exit
fi
## Защита от мультизапуска
LOCK=/tmp/monitoring.lock
if [ -f $LOCK ];then
	echo "Script is already running"
	exit 6
fi
touch $LOCK
trap 'rm -f "$LOCK"; exit $' INT TERM EXIT

## Создаем файл output.log
dt=`date '+%d-%m-%Y_%H-%M-%S'`
OUTPUT=output_$dt.log
touch $OUTPUT
echo "Лог с момента $ll_d $ll_t" >> $OUTPUT

## Пути до access.log, error.log
access=access-4560-c8671a.log
error=error-4560-d75c02.log

## Проверка на наличие файла и установка последнего запуска
if [ ! -f output*.log ]; then
	ll_d=`date -d '1 hour ago' "+%Y-%m-%d"`
	ll_t=`date -d '1 hour ago' "+%H:%M:%S"`
echo FILE CREATED
else

#Работа с датой последнего запуска скрипта . lastlaunch
	# Формат 2018-11-12 

	ll_d=`ls -alt --full-time output* | head -n 1 | awk '{print $6}'`
	#ll_d="2018-11-08"
	 Формат 17:56:19
	ll_t=`ls -alt --full-time output* | head -n 1 | awk '{print $7}' | cut -f1 -d"."`
	#ll_t="04:26:05"
fi

# Замена месяца. Форматирование в вид 12/Nov/2018
ll_ac="[`echo $ll_d | awk -F "-" '{print $3,$2,$1}' | sed 's/ /-/g' | {
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

echo "ACCESS: $ll_ac"
ll_er="`echo $ll_d | sed 's/-/\//g'` $ll_t"
#echo "ERROR: $ll_er"

# X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта 	
echo "IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" > $OUTPUT

awk -v p="$ll_ac" '{if ($4 >= p) print $1}' $access | sort | uniq -c | sort -rn | head -n $1 >> $OUTPUT

# Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
echo "запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта" >> $OUTPUT
awk -v p="$ll_ac" '{if ($4 >= p) print $7}' $access | sort | uniq -c | sort -nr | head -n $2 >> $OUTPUT

# все ошибки c момента последнего запуска
echo "все ошибки c момента последнего запуска" >> $OUTPUT
ll_d=`echo $ll_d | sed 's/-/\//g'`
awk -v p="$ll_d" -v l="$ll_t" '{if (($1 >= p)&&($2 >= l)) print}' $error >> $OUTPUT

# список всех кодов возврата с указанием их кол-ва с момента последнего запуска
echo "список всех кодов возврата с указанием их кол-ва с момента последнего запуска" >> $OUTPUT
awk -v p="$ll_ac" '{if ($4 >= p) print $9}' $access | sort | uniq -c | sort -rn >> $OUTPUT

cat $OUTPUT
mail -s "Stat from nginx server $dt" timur.hisamov@gmail.com < $OUTPUT

# Снимаем трап
rm -f $LOCK
trap - INT TERM EXIT
