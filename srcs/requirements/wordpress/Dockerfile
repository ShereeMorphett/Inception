
# syntax=docker/dockerfile:1
FROM alpine:3.18


RUN apk update && \
	apk add --no-cache bash

COPY conf/wp-config.php php/7.3/fpm/pool.d/
# Add a script that prints with color

ADD tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Set the entrypoint script as the default command
CMD ["/entrypoint.sh"]