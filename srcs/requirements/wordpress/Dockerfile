
# syntax=docker/dockerfile:1
FROM alpine:3.18

RUN apk update && apk add --no-cache --update curl bash vim mariadb-client php php-phar php-json php-curl php-fpm php-mysqli php-iconv

RUN	adduser -S nginx &&	addgroup -S nginx
COPY conf/www.conf /etc/php7/php-fpm.d/www.conf

# installs wordpress CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN cp wp-cli.phar /usr/bin/wp

ADD tools/entrypoint.sh /entrypoint.sh

WORKDIR /var/www/html/wordpress

ADD tools/config.sh /tmp/config.sh
ENTRYPOINT [ "sh", "/tmp/config.sh" ]
