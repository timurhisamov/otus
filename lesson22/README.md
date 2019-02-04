#   DNS - настройка и обслуживание. DHCP.

### Настраиваем split-dns. Взять стенд https://github.com/erlong15/vagrant-bind. Добавить еще один сервер client2. Завести в зоне dns.lab имена: web1 - смотрит на клиент1; web2 смотрит на клиент2. Завести еще одну зону newdns.lab. В ней завести запись www, которая смотрит на обоих клиентов.

#### Дз находится в директории ./vagrant-bind/provisioning

```bash
#client2 создан
[vagrant@client2 ~]$ dig web2.dns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-73.el7_6 <<>> web2.dns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 36334
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web2.dns.lab.			IN	A

;; ANSWER SECTION:
web2.dns.lab.		3600	IN	A	192.168.50.16

;; AUTHORITY SECTION:
dns.lab.		3600	IN	NS	ns02.dns.lab.
dns.lab.		3600	IN	NS	ns01.dns.lab.

;; ADDITIONAL SECTION:
ns01.dns.lab.		3600	IN	A	192.168.50.10
ns02.dns.lab.		3600	IN	A	192.168.50.11

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Пн фев 04 22:13:27 UTC 2019
;; MSG SIZE  rcvd: 127

```

```bash
#зона newdns.lab создана
[vagrant@client1 ~]$ dig @192.168.50.10 www.newdns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-73.el7_6 <<>> @192.168.50.10 www.newdns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 11975
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.newdns.lab.			IN	A

;; ANSWER SECTION:
www.newdns.lab.		3600	IN	A	192.168.50.16
www.newdns.lab.		3600	IN	A	192.168.50.15

;; AUTHORITY SECTION:
newdns.lab.		3600	IN	NS	ns02.dns.lab.
newdns.lab.		3600	IN	NS	ns01.dns.lab.

;; ADDITIONAL SECTION:
ns01.dns.lab.		3600	IN	A	192.168.50.10
ns02.dns.lab.		3600	IN	A	192.168.50.11

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Пн фев 04 22:06:52 UTC 2019
;; MSG SIZE  rcvd: 149
```

### Настроить split-dns, так чтобы client1 - видел 2 зоны, но в зоне dns.lab только web1, а client2 видел только dns.lab

#### Дз находится в директории ./vagrant-bind/provisioning-view

```bash
#client1 не видит web2
[vagrant@client1 ~]$ dig @192.168.50.10 web2.dns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-73.el7_6 <<>> @192.168.50.10 web2.dns.lab
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 33180
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web2.dns.lab.			IN	A

;; AUTHORITY SECTION:
dns.lab.		600	IN	SOA	ns01.dns.lab. root.dns.lab. 2711201408 3600 600 86400 600

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Пн фев 04 22:09:35 UTC 2019
;; MSG SIZE  rcvd: 87
```

```bash
#client2 не видит зону newdns.lab
[vagrant@client2 ~]$ dig www.newdns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-73.el7_6 <<>> www.newdns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 20651
;; flags: qr rd ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.newdns.lab.			IN	A

;; AUTHORITY SECTION:
.			10566	IN	SOA	a.root-servers.net. nstld.verisign-grs.com. 2019020401 1800 900 604800 86400

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Пн фев 04 22:00:32 UTC 2019
;; MSG SIZE  rcvd: 118
```