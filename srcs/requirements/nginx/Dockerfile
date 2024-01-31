FROM alpine:3.18.5

RUN apk update && \
    apk add --no-cache nginx openssl

# Nginx SSL
RUN mkdir /etc/nginx/ssl

# Copy Nginx configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf


COPY ./index.html /usr/share/nginx/html/index.html

# Nginx config
RUN mkdir -p /run/nginx

EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
