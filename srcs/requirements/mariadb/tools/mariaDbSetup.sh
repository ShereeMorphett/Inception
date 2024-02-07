#!/bin/bash
set -e

# Create WordPress database
mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"

# Create WordPress user
mysql -e "CREATE USER IF NOT EXISTS 'wordpress'@'%' IDENTIFIED BY 'your_password';"

# Grant privileges to the WordPress user on the WordPress database
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';"

# Flush privileges
mysql -e "FLUSH PRIVILEGES;"
