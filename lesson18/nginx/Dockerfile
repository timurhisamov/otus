FROM alpine:3.8
RUN apk update \
    &&  apk upgrade \
    &&  apk add nginx \
    && adduser -D -g 'www' www \
    && mkdir /www \
    && chown -R www:www /var/lib/nginx \
    && chown -R www:www /www 
COPY nginx.conf /etc/nginx/
COPY index.html /www/index.html
EXPOSE 80
CMD ["nginx", "-g"]