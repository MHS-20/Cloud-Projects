#!/bin/bash

# aws cloudformation describe-stacks --stack-name NOME_DEL_TUO_STACK --query 'Stacks[0].Outputs'

# Configurazioni per RDS
DBInstanceIdentifier="mysql-for-wordpress"
DB_NAME="wordpress_db"
DB_USER="wordpress_user"
DB_PASSWORD="your_db_password"
RDS_ENDPOINT="$(aws rds describe-db-instances --db-instance-identifier $DBInstanceIdentifier \
    --query 'DBInstances[0].Endpoint.Address' --output text)"

# Altri parametri WordPress
WP_URL="http://your-wordpress-url.com"
WP_TITLE="Your WordPress Site"
WP_ADMIN_USER="admin"
WP_ADMIN_PASSWORD="your_admin_password"
WP_ADMIN_EMAIL="admin@example.com"

# Installa LAMP Stack (Linux, Apache, MySQL, PHP)
sudo apt-get update
sudo apt-get install -y apache2 php libapache2-mod-php

# Imposta il file di configurazione di WordPress
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sudo sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sudo sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/wp-config.php
sudo sed -i "s/localhost/$RDS_ENDPOINT/" /var/www/html/wp-config.php

# Imposta URL di WordPress
echo "define('WP_HOME', '$WP_URL');" | sudo tee -a /var/www/html/wp-config.php
echo "define('WP_SITEURL', '$WP_URL');" | sudo tee -a /var/www/html/wp-config.php

# Imposta il titolo e l'utente amministratore
sudo wp --path=/var/www/html/ core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"

# Riavvia Apache
sudo service apache2 restart
