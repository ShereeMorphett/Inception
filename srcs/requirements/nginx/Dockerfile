FROM alpine:3.18.5

WORKDIR /etc/nginx/

RUN apk update \
    && apk add --no-cache && apk add nginx \
	&& adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www

RUN mkdir -p /var/www/html /var/log/nginx /var/run/nginx \
    && chown -R nginx:nginx /var/www/html /var/log/nginx /var/run/nginx

COPY ./conf/default.conf default.conf
COPY ./index.html /var/www/html/

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
