# Сетевые пакеты. VLAN'ы. LACP. 

## Домашнее задание

Для проверки vlan:

```bash
vagrant up office1Router testClient1 testClient2 testServer1 testServer2    
```

Для проверки bonding (rr):

```bash
vagrant up inetRouter centralRouter   
```

LACP поднять не получилось, journalctl -xe выдает: 

![1.png](images/1.png)