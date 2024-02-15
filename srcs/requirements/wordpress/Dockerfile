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
        mariadb-client

# Command line tools for WordPress, you may not need wget anymore
ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /usr/local/bin/wp

RUN chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html

# WORKDIR /var/www/html/
# # Expose the PHP FPM port
# EXPOSE 9000

# Temporary infinite loop script to allow testing in the image
COPY ./tools/config.sh /bin/config.sh

RUN chmod +x /bin/config.sh

ENTRYPOINT ["/bin/config.sh"]

WORKDIR /var/www/html/

EXPOSE 9000
# may be different on VM
CMD ["/usr/sbin/php-fpm81", "-F", "-R"] 