#!/usr/bin/sh

while ! mariadb -h$MYSQL_HOST -u$WORDPRESS_DB_USER -p$WORPPRESS_DB_PASSWORD $WORDPRESS_DB_NAME &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.html" ]; then
    wp core download
    wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDRESS_DB_USR --dbpass=$WORDRESS_DB_PWD --dbhost=$MYSQL_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci"
    wp core install --url=$DOMAIN_NAME/wordpress --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL
    wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=author --user_pass=$WORDPRESS_PASSWORD
    wp theme install inspiro --activate
    wp plugin update --all 
fi

php-fpm7 --nodaemonize