#!/bin/sh

# Maximum number of retries
MAX_RETRIES=5
# Sleep duration between retries (in seconds)
RETRY_INTERVAL=5
# Counter to track the number of attempts
attempt=0

# Function to check if mariadb is available
check_mariadb() {
    wget --spider -q mariadb:3306
}

# Wait for mariadb to become available
while [ $attempt -lt $MAX_RETRIES ]; do
    if check_mariadb; then
        echo "Database connection successful."
        break
    else
        echo "Waiting for database connection..."
        sleep $RETRY_INTERVAL
    fi
    attempt=$((attempt + 1))
done

# Check if maximum retries reached
if [ $attempt -eq $MAX_RETRIES ]; then
    echo "Maximum retries reached. Exiting..."
    exit 1
fi

# Proceed with the script

mkdir -p var/www/html/wordpress /run/php/
cd /var/www/html/

if [ -f "./.wpExists" ]; then
    echo "Wordpress already exists"
else
	touch ./.wpExists
	# WordPress setup commands
	wp core download --allow-root
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=mariadb --path=/var/www/html/ --force
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --path=/var/www/html/ --allow-root
	wp user create $WP_USER $WP_USER_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD --path=/var/www/html/
	wp theme install twentysixteen --activate --allow-root
	wp plugin update --all
	wp option update siteurl "https://$DOMAIN_NAME"
	wp option update home "https://$DOMAIN_NAME"
fi

# Change ownership and permissions
chown -R www:www /var/www/html
chmod -R 775 /var/www/html

# Run php-fpm in foreground
exec /usr/sbin/php-fpm81 -F
