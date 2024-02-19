#!/bin/sh

#now add a waiting timer to wait for maria db

if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wp core download --allow-root
	
	#wp create the config with wp config creat && wp core install ......
	#wp user create and then set themes etc from here and set options
	#Inport env variables in the config file
	cd /var/www/html/wordpress
	sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config-sample.php
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOST/g" wp-config-sample.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config-sample.php
	# mv wp-config-sample.php wp-config.php
fi
chown -R www:www /var/www/html
chmod -R 775 /var/www/html
exec /usr/sbin/php-fpm81 -F



# #!/bin/sh


# # # download wordpress use WP-CLI instead
# # wget https://wordpress.org/latest.tar.gz
# # # unpack wordpress
# # tar -xf latest.tar.gz
# # download cli for wordpress
# # download wordpress with wp-cli allowing the root user to do so

# # while ! mysql -u $DB_USER -p $DB_USER_PASSWORD -h mariadb $DB_NAME; do
# # 	sleep 5
# # done

# cd /var/www/html/
# wp core download --allow-root

# # change directory to where you want them first (may need to make one)


# #setup with the wp-cli https://www.cloudways.com/blog/wp-cli-commands/
# # make config
# #skip check to be removed once database is connected and running
# wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=mariadb --path=/var/www/html/ --force

# # install wordpress
# wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --path=/var/www/html/ --allow-root
# # make user
# # --path=/var/www/html maybe set as same location as volume
# wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --role=editor --user_pass=$WORDPRESS_PASSWORD --path=/var/www/html/
# # install themes and plugins
# wp theme install pixl --activate
# # activate stuff e.g. themes
# # wp theme activate pixl
# wp plugin update --all

# wp option update siteurl "https://$DOMAIN_NAME"
# wp option update home "https://$DOMAIN_NAME"

# # while [ true ] 
# # do
# # 	sleep 1
# # done
# chown -R nginx:nginx /var/www/html
# chmod -R 755 /var/www/html/wordpress

# exec php-fpm81
