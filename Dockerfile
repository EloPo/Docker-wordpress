FROM debian:9.0

LABEL Eloisa Potrich <eloisa.potrich@rivendel.com.br>

RUN apt-get update && apt-get install -y \
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
		supervisor \
		&& apt-get clean


# Certificado para o wordpress
# RUN openssl genrsa -out client.key 4096 && openssl req -new -x509 -text -key client.key -out client.cert
# RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
# RUN update-ca-certificates
# Copiando o certificado gerado para uma pasta especifica 
# COPY ./mycert.crt /usr/local/share/ca-certificates/mycert.crt

COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD wordpress-5.2.2-pt_BR.zip /var/www

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
