FROM alpine:3.18.6

RUN apk update \
    && apk add --no-cache \
        php \
        php-fpm \
        php-mysqli \
        php-phar \
        php-mbstring \
        curl \
        libcurl \
        php-curl \
        libzip \
        php-zip \
        mariadb-client \
	wget

RUN adduser -D -g 'www' www && mkdir -p /www && chown -R www:www /www

# Command line tools for WordPress, you may not need wget anymore
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html

WORKDIR /var/www/html/

EXPOSE 9000

# Temporary infinite loop script to allow testing in the image
COPY ./tools/config.sh /bin/config.sh
COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf

RUN chmod +x /bin/config.sh
RUN chmod -R 755 /var/www/html/

WORKDIR /var/www/html/

EXPOSE 9000

ENTRYPOINT ["/bin/config.sh"]
