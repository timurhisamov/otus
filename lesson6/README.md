#   Инициализация системы. Systemd и SysV.

##  1. Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должны задаваться в /etc/sysconfig

- keyboard.service #	systemd сервис, проверяет наличие ключевого слова в приложении. Лежит в /etc/systemd/system/

- keyword_start.sh #	скрипт запуска;

- keyword_stop.sh #		скрипт остановки;

- keyword #		настройки в /etc/sysconfig/.

##  2. Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно так же называться.

- spawn-cgi.service #	systemd сервис spawn-cgi

- spawn-cgi.socket #	сокет

##  3. Дополнить юнит-файл apache httpd возможностьб запустить несколько инстансов сервера с разными конфигами

- httpd@.service #	systemd сервис веб-сервера httpd. Позволяет запускать несколько инстансов

- httpd1.conf #		первый конфиг

- httpd2.conf #		второй конфиг

##  4. Скачать демо-версию Atlassian Jira и переписать основной скрипт запуска на unit-файл

- jira.service systemd #	сервис jira