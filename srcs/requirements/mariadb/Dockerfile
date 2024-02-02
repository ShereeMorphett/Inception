
FROM alpine:3.18.5


# Install required utilities
RUN apk add --no-cache bash

# Add a script that prints with color
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint script as the default command
CMD ["/entrypoint.sh"]