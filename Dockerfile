FROM nginx
MAINTAINER rizkypanz

RUN apt update
RUN apt -y install nginx software-properties-common nano
RUN apt update
RUN apt -y install php7.4
RUN apt -y install php7.4-fpm php7.4-common php7.4-mysql php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip unzip php7.4-json

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf-origin
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf-origin
RUN mv /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf-origin

ADD config/default.conf /etc/nginx/conf.d/default.conf
ADD config/nginx.conf /etc/nginx/nginx.conf
ADD config/www.conf /etc/php/7.4/fpm/pool.d/www.conf
ADD config/index.php /usr/share/nginx/html/index.php

# Redirect php-fpm logs to stdout
RUN ln -sf /dev/stdout /var/log/php7.4-fpm.log

EXPOSE 80

#  Start php7.4-fpm & nginx 
CMD service php7.4-fpm start && nginx -g "daemon off;"
