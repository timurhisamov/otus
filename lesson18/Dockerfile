FROM alpine:3.8
RUN apk update \
    &&  apk upgrade \
    &&  apk add nginx 
COPY index.html /usr/share/html/index.html
EXPOSE 80
CMD ["nginx"]