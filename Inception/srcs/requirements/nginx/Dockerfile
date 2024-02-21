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

RUN mkdir ./ssl && \
	openssl req -x509 -newkey rsa:4096 \
	-keyout ./ssl/smorphet.key -sha256 -days 365 -nodes \
	-out ./ssl/smorphet.crt \
	-subj "/C=FI/ST=Helsinki/L=Helsinki/O=42 School/OU=smorphet/CN=smorphet.42.fr"

COPY ./conf/default.conf ./http.d/default.conf


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]