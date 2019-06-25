FROM debian:9.0

LABEL maintainer="eloisa.potrich@rivendel.com.br"

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y php
RUN apt-get install -y supervisor
RUN apt-get clean

# RUN openssl req -newkey rsa:2048 -nodes -keyout exemplo.com.key -out exemplo.com.csr && cat ca_exemplo1.crt ca_exemplo2.crt ca_exemplo3.crt > intermediate.crt

COPY ./config/php.ini /etc/php/${PHP_VER}/fpm/conf.d/zzz-custom.ini
COPY ./config/php-fpm.conf /etc/php/${PHP_VER}/fpm/pool.d/zzz-custom.conf
COPY ./config/nginx-main.conf /etc/nginx/nginx.conf
COPY ./config/nginx-host.conf /etc/nginx/conf.d/default.conf
COPY ./config/wordpress.conf /etc/wordpress/conf.d/wordpress.conf
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD ./wordpress-5.2.2-pt_BR.zip /var/www


VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]
VOLUME ["/etc/supervisor/conf.d"]
VOLUME /etc/ssl/certs/wordpress/
VOLUME /etc/ssl/private/wordpress/

WORKDIR /etc/nginx
WORKDIR /etc/supervisor/conf.d

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]