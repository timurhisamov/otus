В данном Домашнем Задании рассмотрел 2 вариант сборки рейда:

- один Vagrantfile (provisioning shell через INLINE)
- Vagrantfile со внешним скриптом (provisioning shell через путь к скрипту)

*Vagrantfile.RAIDviaScript*	позволяет собрать RAID5 через provisioning shell, используя скрипт createRAID5.sh

*Vagrantfile.RAID*		позволяет собрать RAID5, имея только один Vagrantfile

*mdadm.conf*			конфиг файл для автосборки рейда при загрузки ОС

*createRAID5.sh*			скрипт, предназначенный для автосборки, монтирования RAID5 на vm, достаточно положить в папку рядом с 
Vagrantfile. Затем зайти на vm, и выполнить sh /vagrant/createRAID5.sh

