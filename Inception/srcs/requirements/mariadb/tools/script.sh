#!/bin/sh

# make sure environment vars are set
if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
  echo "Error: MARIADB_ROOT_PASSWORD environment variable is not set."
  exit 1
fi
if [ -z "$DB_USER" ] || [ -z "$DB_USER_PASSWORD" ]; then
  echo "Error: DB_USER and/or DB_USER_PASSWORD environment variable is not set."
  exit 1
fi

# to change ownership of database files in /run/mysqld /var/lib/mysqld
mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
touch /var/log/mysql/error.err

# Initialize database and users
echo "Initializing database and users"
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm >/dev/null

# Start MariaDB service
echo "Starting MariaDB service"
mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock --pid-file=/run/mysqld/mysqld.pid &

# Wait for MariaDB to start
echo "Waiting for MariaDB to start..."
until mysqladmin ping -h localhost --silent; do
    sleep 1
done

# Change root password and create database and user
echo "Creating database and user"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;"
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_USER_PASSWORD}';"
mysql -u root -p"${MARIADB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"

# Stop MariaDB service
echo "Stopping MariaDB service"
mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown

# Start MariaDB service in the foreground
echo "Starting MariaDB service in the foreground"
exec mysqld_safe "--defaults-file=/etc/my.cnf.d/my.cnf"
