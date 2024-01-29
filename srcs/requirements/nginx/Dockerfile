FROM alpine:3.18.6

RUN apk update \
    && apk add --no-cache nginx \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/html /var/log/nginx /var/run/nginx \
    && chown -R nginx:nginx /var/www/html /var/log/nginx /var/run/nginx

COPY ./conf /etc/nginx/nginx_configuration.conf
COPY ./index.html /var/www/html/

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
