FROM alpine:3.18.6


RUN apk update && \
    apk add mariadb mariadb-client && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

# Expose the MySQL port
EXPOSE 3306

# Copy entrypoint script into the container
COPY ./tools/entrypoint.sh /usr/local/bin/
COPY ./conf/50-server.conf /etc/mariadb/50-server.conf

# Set the entrypoint script as executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint script as the entry point for the container
ENTRYPOINT ["entrypoint.sh"]

# Command to launch MariaDB and enable the database to listen globally
CMD ["mysqld", "--bind-address=0.0.0.0"]
