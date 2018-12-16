#   LDAP. Централизованная авторизация и аутентификация.

##  1. Установить FreeIPA

- script.log #	лог установки FreeIPA сервера

- Vagrantfile # конфигурации виртуальных машин с shell provision сервера FreeIPA

##  2. Написать playbook для конфигурации клиента

- ipa-client-install.yml  # ansible-playbook установки и настройки клиента Free IPA

##  3. Всю "сетевую лабораторию" перевести на аутентификацию через LDAP

![image1](images/image1.png)

##  4*. Настроить авторизацию по ssh-ключам

- ipa-ssh-client  # команды для добавления пользователю возможности аутентификации по ssh-key
