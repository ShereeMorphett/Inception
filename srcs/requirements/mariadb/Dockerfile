
FROM alpine:3.18.5


# Install required utilities
RUN apk add --no-cache mariadb mariadb-client bash

# Add a script that prints with color
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.conf

EXPOSE 3306

# Set the entrypoint script as the default command
CMD ["/entrypoint.sh"]