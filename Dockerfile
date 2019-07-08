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
  	php7.0-cli \
  	libapache2-mod-php7.0

RUN apt-get install -y \
		python-pip \
		supervisor \
		&& apt-get clean

# COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD wordpress-5.2.2-pt_BR.zip /var/www

EXPOSE 80 443 9000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]