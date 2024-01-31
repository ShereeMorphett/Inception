
# FROM alpine:3.18.5

# RUN apk update && \
#     apk add --no-cache openssl nginx

# COPY ./generate_ssl.sh /usr/local/bin/generate_ssl.sh
# RUN chmod +x /usr/local/bin/generate_ssl.sh

# RUN mkdir -p /etc/nginx/ssl

# COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# COPY ./index.html /usr/share/nginx/html/index.html

# RUN mkdir -p /run/nginx

# EXPOSE 443

# # Start nginx
# CMD ["nginx", "-g", "daemon off;"]

FROM alpine:3.18.5

RUN apk update \
    && apk add --no-cache openssl && apk add nginx \
	&& adduser -D -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www

# Nginx SSL
RUN mkdir /etc/nginx/ssl

RUN mkdir -p /var/www/html /var/log/nginx /var/run/nginx \
    && chown -R nginx:nginx /var/www/html /var/log/nginx /var/run/nginx

# Copy Nginx configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./index.html /usr/share/nginx/html/index.html

# Nginx config
RUN mkdir -p /run/nginx

EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]