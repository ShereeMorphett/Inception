#!/bin/bash
set -e

# Start MariaDB
mysqld_safe --skip-networking &

# Wait for the MariaDB server to start
until mysqladmin ping &>/dev/null; do
    echo -n "."; sleep 1
done

# Run the setup script to create the WordPress database and user
/tmp/mariadb-setup.sh

# Stop MariaDB
mysqladmin shutdown

# Start MariaDB in normal mode
exec mysqld_safe
