FROM alpine:3.18.6

RUN apk update \
    && apk add --no-cache openssl && apk add nginx \
    && adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www

# Nginx SSL
RUN mkdir /etc/nginx/ssl

RUN  openssl req -x509 -nodes -newkey rsa:4096 -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt -sha256 -days 365 \
    -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=Hive/OU=smorphet/CN=smorphet.42.fr"

RUN mkdir -p /var/www/html /var/log/nginx /var/run/nginx \
    && chown -R nginx:nginx /var/www/html /var/log/nginx /var/run/nginx

# Copy Nginx configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./index.html /usr/share/nginx/html/index.html

# Nginx config
RUN mkdir -p /run/nginx

EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
