FROM alpine:3.18

CMD ["echo", "Hello"]

RUN apk update \
    && apk add --no-cache \
        nginx \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/html /var/log/nginx /var/run/nginx \
    && chown -R nginx:nginx /var/www/html /var/log/nginx /var/run/nginx

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
