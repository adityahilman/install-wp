WORDPRESS_URL="https://wordpress.org/latest.tar.gz"

WORKDIR="./"
#WORKDIR="/opt/htdocs/vhost/"

echo "Input New Domain: "
read -e NEW_DOMAIN

if [ -d "$WORKDIR/$NEW_DOMAIN" ]; then
    echo "Domain already exist" 
    exit 1
else
    echo "Creating WP DocRoot $WORKDIR/$NEW_DOMAIN"
    mkdir -p $WORKDIR/$NEW_DOMAIN
    echo "Downloading Wordpress"
    #wget $WORDPRESS_URL
    tar zxf latest.tar.gz
    mv wordpress/* $NEW_DOMAIN

    echo "=== Installing Wordpress ==="

    echo "Input Database Name :"
    read -e DB_WP_NAME

    echo "Input Database User :"
    read -e DB_WP_USER

    echo "Input Database Password :"
    read -e DB_WP_PASSWORD

    echo "Input Database Host :"
    read -e DB_WP_HOST
    
    cp $NEW_DOMAIN/wp-config-sample.php $NEW_DOMAIN/wp-config.php

    sed -i bak -e "s/database_name_here/$DB_WP_NAME/" $NEW_DOMAIN/wp-config.php
    sed -i bak -e "s/username_here/$DB_WP_USER/" $NEW_DOMAIN/wp-config.php
    sed -i bak -e "s/password_here/$DB_WP_PASSWORD/" $NEW_DOMAIN/wp-config.php
    sed -i bak -e "s/localhost/$DB_WP_HOST/" $NEW_DOMAIN/wp-config.php
    rm -f $NEW_DOMAIN/wp-config.phpbak

    # Generate WP Salt
    perl -i -pe'
        BEGIN {
        @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
        push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
        sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
    }
    s/put your unique phrase here/salt()/ge
    ' $NEW_DOMAIN/wp-config.php

    echo "Installing Apache config"
    cp apache-wp.conf $NEW_DOMAIN.conf
    sed -e "s/NEW_DOMAIN/$NEW_DOMAIN/" apache-wp.conf > $NEW_DOMAIN.conf

    #sed -i "s/NEW_DOMAIN/$NEW_DOMAIN/" $NEW_DOMAIN.conf




fi

