FROM debian:9.0

LABEL Eloisa Potrich <eloisa.potrich@rivendel.com.br>

RUN apt-get update && apt-get install -y \
		curl \
		nginx \
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
  	libapache2-mod-php7.0 \
		# supervisor \
		openssl \
		&& apt-get clean

RUN apt-get install python-pip -y
# Supervisor Config
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install Wordpress
ADD wordpress-5.2.2-pt_BR.zip /var/www

# private expose
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
