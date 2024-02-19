FROM alpine:3.18.6


RUN apk update && \
    apk add mariadb mariadb-client && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld


EXPOSE 3306

COPY ./tools/entrypoint.sh /usr/local/bin/
COPY ./conf/50-server.conf /etc/mariadb/50-server.conf

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

#CMD ["mysqld_safe", "--defaults-file=/etc/mariadb/50-server.conf"]
