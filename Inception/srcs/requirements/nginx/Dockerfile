FROM alpine:3.18.6

RUN apk update && \
	apk add --no-cache \
    nginx \
    openssl

EXPOSE 443

RUN mkdir -p /run/nginx /etc/nginx/ssl

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/certificate.crt \
    -keyout /etc/nginx/ssl/certificate.key \
    -subj "/C=FI/ST=Helsinki/L=Helsinki/O=Hive/OU=smorphet/CN=smorphet.42.fr"

RUN addgroup -S www && \
	adduser -S -H -g "" www -G www

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

RUN sed -i 's/user nginx/user www www/' /etc/nginx/nginx.conf && \
	sed -i 's/ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;/ssl_protocols TLSv1.2 TLSv1.3;/' /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
