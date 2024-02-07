
FROM alpine:3.18.5


# Install required utilities
RUN apk update && \
	apk add --no-cache bash mariadb mariadb-client

# Add a script that prints with color
ADD tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#subject requires DB and wordpress to be on this pot
EXPOSE 3306

#winging this the paths etc could be soo wrong!
COPY conf/50-server.conf /etc/mariadb/50-server.conf  
RUN chmod 644 /etc/mariadb/50-server.conf

# Set the entrypoint script as the default command
CMD ["/entrypoint.sh"]


# COPY ./tools/mariadb-setup.sh /tmp/mariadb-setup.sh
# RUN chmod +x /tmp/mariadb-setup.sh
