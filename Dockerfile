FROM debian:9.0

LABEL Eloisa Potrich <eloisa.potrich@rivendel.com.br>

RUN apt-get update && apt-get install -y \
		curl \
		nginx 

RUN apt-get install -y \
		php7.0 \
  	php7.0-dev \
  	php7.0-fpm \
  	php7.0-json \
  	php7.0-mysql \
  	php7.0-mcrypt \
  	php7.0-common \
  	php7.0-opcache \
  	php7.0-readline \
  	php7.0-gd \
  	php7.0-xml \
  	php7.0-zip \
  	php7.0-curl \
  	php7.0-cli 

RUN apt-get install -y supervisor && apt-get clean

COPY ./config/php.ini /etc/php/7.0/fpm/php.ini
COPY ./config/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
COPY ./config/nginx.conf /etc/init.d/nginx.conf
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD wordpress-5.2.2-pt_BR.zip /var/www

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]