# Pull base image
FROM hypriot/rpi-alpine-scratch

# default database autoconfig
ENV DBTYPE=mysql \
    DBNAME=owncloud \
    DBUSER=owncloud \
    DBPASS=owncloud \
    DBHOST=mysql

# install
# 1. install ngnix
# 2. install php
# 3. install Owncloud
# 4. fix php-fpm "Error relocating /usr/bin/php-fpm: __flt_rounds: symbol not found" bug
RUN apk update \
    && apk add bash \
    nginx \
    php-fpm \
    php-json \
    ca-certificates \
    php-openssl \
    owncloud-mysql \
    owncloud-videoviewer \
    owncloud-tasks \
    owncloud-texteditor \
    owncloud-calendar \
    owncloud-contacts \
    && rm -rf /var/cache/apk/*

    # && apk add -u musl \

ADD files/nginx.conf /etc/nginx/
ADD files/php-fpm.conf /etc/php/
ADD files/config.php /tmp/
ADD files/autoconfig.php /tmp/
ADD files/run.sh /
# RUN chmod +x /run.sh

EXPOSE 80
VOLUME ["/DATA"]

CMD ["sh","/run.sh"]
