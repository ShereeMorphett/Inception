#!/bin/sh

# make sure environment vars are set
if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
  echo "Error: MARIADB_ROOT_PASSWORD environment variable not found."
  exit 1
fi
if [ -z "$WORDPRESS_DB_USER" ] || [ -z "$WORDPRESS_DB_PASSWORD" ]; then
  echo "Error: DB_USER or DB_USER_PASSWORD environment variable not found."
  exit 1
fi

mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
touch /var/log/mysql/error.err
chown -R mysql:mysql /var/log/mysql/error.err

#give commands to database using root user, no password to begin with
echo "Intializing database"
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm >/dev/null 

echo "Intializing database and users"
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${WORDPRESS_DB_USER}'@'%' IDENTIFIED by '${WORDPRESS_DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';
GRANT ALL PRIVILEGES ON *.* TO '${WORDPRESS_DB_USER}'@'%';

FLUSH PRIVILEGES;
EOF

exec mysqld_safe --defaults-file=/etc/my.cnf.d/50-server.cnf
