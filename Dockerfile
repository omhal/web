FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

# install NGINX
RUN apt-get update && \
	apt-get install -y nginx --no-install-recommends && \
	rm -rf /var/lib/apt/lists/*

# install
RUN apt-get update
RUN apt-get install -y \
     git \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg\
     software-properties-common
RUN rm -rf /var/lib/apt/lists/*

RUN curl https://packages.sury.org/php/apt.gpg | apt-key add -
RUN echo 'deb https://packages.sury.org/php/ stretch main' > /etc/apt/sources.list.d/deb.sury.org.list

#RUN 7.2
RUN apt-get update && \
	apt-get install -y php7.2-fpm php7.2-cli php7.2-common php7.2-opcache php7.2-curl php7.2-mbstring php7.2-zip php7.2-xml php7.2-gd php7.2-mysql --no-install-recommends && \
	rm -rf /var/lib/apt/lists/*

#POSTGRE PDO INSTALL
#RUN apt-get update && \
#	apt-get install -y php7.2-pgsql --no-install-recommends && \
#	rm -rf /var/lib/apt/lists/*

# php-redis install
#RUN apt-get update && \
#	apt-get install -y php-redis --no-install-recommends && \
#	rm -rf /var/lib/apt/lists/*


RUN useradd -ms /bin/bash nginx

# nano install
RUN apt-get update && \
	apt-get install -y nano --no-install-recommends && \
	rm -rf /var/lib/apt/lists/*

#Timezone
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Composer installation.
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer global require hirak/prestissimo --prefer-dist --no-progress --no-suggest --classmap-authoritative \
	&& composer clear-cache
ENV PATH="${PATH}:/root/.composer/vendor/bin"


COPY php7proxy /etc/nginx/php7proxy
COPY nginx.conf /etc/nginx/
COPY fe.conf /etc/nginx/conf.d/fe.conf
COPY php.ini /etc/php/7.2/fpm/
COPY www.conf /etc/php/7.2/fpm/pool.d/


EXPOSE 80

CMD /etc/init.d/php7.2-fpm start && nginx -g "daemon off;"
