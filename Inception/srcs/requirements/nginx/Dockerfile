FROM alpine:3.18.6

# WORKDIR /etc/nginx/

RUN apk update && \
	apk --no-cache add openssl

RUN apk update && \
	apk add --no-cache nginx && \
	adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

RUN mkdir /etc/nginx/ssl && \
	openssl req -x509 -newkey rsa:4096 \
	-keyout /etc/nginx/ssl/certificate.key -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/certificate.crt \
	-subj "/C=FI/ST=Helsinki/L=Helsinki/O=42 School/OU=smorphet/CN=smorphet.42.fr"

RUN sed -i 's/user nginx;/user www;/' /etc/nginx/nginx.conf

COPY ./conf/default.conf /etc/nginx/http.d/default.conf


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
