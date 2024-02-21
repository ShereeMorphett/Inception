FROM alpine:3.18.6

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

EXPOSE 3306

COPY ./conf/my.cnf /etc/my.cnf.d/my.cnf
COPY tools/script.sh /tmp/mariadb-setup.sh
RUN chmod +x /tmp/mariadb-setup.sh

CMD ["sh",  "/tmp/mariadb-setup.sh"] 
