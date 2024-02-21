#!/bin/sh

while ! wget --spider -q mariadb:3306; do
    echo "Waiting for database connection..."
    sleep 5
done

mkdir -p var/www/html/wordpress  /run/php/
cd /var/www/html/
# if [ ! -f "/var/www/html/.wordpress_installed" ]; then
	#Download wordpress files
 	wp core download --allow-root
	#create config with wp-cli
	wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=mariadb --path=/var/www/html/ --force
	# install wordpress
	wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --path=/var/www/html/ --allow-root
	#Create user
 	wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=editor --user_pass=$WP_USER_PASSWORD --path=/var/www/html/
	# install themes and plugins
	wp theme install twentysixteen --activate --allow-root
	wp plugin update --all
 	# 
	wp option update siteurl "https://$DOMAIN_NAME"
	wp option update home "https://$DOMAIN_NAME"
	touch /var/www/html/.wordpress_installed
# else
# 	echo "wordpress already downloaded and setup"
# fi

chown -R www:www /var/www/html
chmod -R 775 /var/www/html

#Run php-fpm in foreground
exec /usr/sbin/php-fpm81 -F