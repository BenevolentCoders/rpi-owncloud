# Pull base image
FROM hypriot/rpi-alpine-scratch

# default database autoconfig
ENV DBTYPE=mysql \
    DBNAME=owncloud \
    DBUSER=ownclouduser \
    DBPASS=owncloudpass \
    DBHOST=mysql \
    ADMINLOGIN=admin \
    ADMINPASS=password

# install
# 1. install ngnix
# 2. install php
# 3. install Owncloud
RUN apk update \
    && apk add bash \
    nginx \
    php-fpm \
    php-json \
    php-curl \
    ca-certificates \
    php-openssl \
    owncloud-mysql \
    owncloud-videoviewer \
    owncloud-pdfviewer \
    owncloud-music \
    owncloud-documents \
    owncloud-tasks \
    owncloud-texteditor \
    owncloud-calendar \
    owncloud-contacts \
    owncloud-external \
    owncloud-encryption \
    owncloud-mozilla_sync \
    && sed -i -e "s/^.*$option_max_2gb_check.* false.*$/public $option_max_2gb_check = false;/" /usr/share/webapps/owncloud/apps/music/3rdparty/getID3/getid3/getid3.php
    && rm -rf /var/cache/apk/*

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php/
ADD files/config.php /tmp/
ADD files/run.sh /

EXPOSE 80
VOLUME ["/DATA"]

CMD ["sh","/run.sh"]
