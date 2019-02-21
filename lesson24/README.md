# Web сервера

### Реализован двойной переход с присвоением cookies. Клиент стучится на /, и в этот момент проверяется наличие кука oneway равного 302, если нет то переадресация на /cookie, где присваивается значение и переадресация в обратную сторону на /. После чего происходит снова проверка cookies и выдача HTTP/1.1 200 OK.

```bash

[root@web nginx]# curl -b none -L -I 127.0.0.1
HTTP/1.1 302 Moved Temporarily
Server: nginx/1.12.2
Date: Mon, 18 Feb 2019 22:49:56 GMT
Content-Type: text/html
Content-Length: 161
Connection: keep-alive
Location: http://127.0.0.1/cookie

HTTP/1.1 302 Moved Temporarily
Server: nginx/1.12.2
Date: Mon, 18 Feb 2019 22:49:56 GMT
Content-Type: text/html
Content-Length: 161
Connection: keep-alive
Location: http://127.0.0.1/
Set-Cookie: oneway=302

HTTP/1.1 200 OK
Server: nginx/1.12.2
Date: Mon, 18 Feb 2019 22:49:56 GMT
Content-Type: text/html
Content-Length: 3700
Last-Modified: Tue, 06 Mar 2018 09:26:21 GMT
Connection: keep-alive
ETag: "5a9e5ebd-e74"
Accept-Ranges: bytes

```