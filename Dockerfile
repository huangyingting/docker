FROM alpine:3.12

LABEL maintainer "Marvin Steadfast <marvin@xsteadfastx.org>"

ARG WALLABAG_VERSION=master

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

ADD https://api.github.com/repos/huangyingting/wallabag/git/refs/heads/$WALLABAG_VERSION version.json

RUN set -ex \
 && apk update \
 && apk upgrade --available \
 && apk add \
      ansible \
      curl \
      git \
      libwebp \
      mariadb-client \
      nginx \
      pcre \
      php7 \
      php7-amqp \
      php7-bcmath \
      php7-ctype \
      php7-curl \
      php7-dom \
      php7-fpm \
      php7-gd \
      php7-gettext \
      php7-iconv \
      php7-json \
      php7-mbstring \
      php7-openssl \
      php7-pdo_mysql \
      php7-pdo_pgsql \
      php7-pdo_sqlite \
      php7-phar \
      php7-session \
      php7-simplexml \
      php7-tokenizer \
      php7-xml \
      php7-zlib \
      php7-sockets \
      php7-xmlreader \
      php7-tidy \
      php7-intl \
      py3-mysqlclient \
      py3-psycopg2 \
      py-simplejson \
      rabbitmq-c \
      s6 \
      tar \
      tzdata \
      make \
      bash \
 && rm -rf /var/cache/apk/* \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log \
 && curl -s https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer \
 && composer selfupdate --1 \
 && git clone --branch $WALLABAG_VERSION --depth 1 https://github.com/huangyingting/wallabag.git /var/www/wallabag

COPY root /

RUN set -ex \
 && cd /var/www/wallabag \
 && SYMFONY_ENV=prod COMPOSER_MEMORY_LIMIT=-1 composer install --no-dev -o --prefer-dist --no-progress --no-interaction \
 && chown -R nobody:nobody /var/www/wallabag \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/itnext.io.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/instagram-engineering.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/netflixtechblog.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/robinhood.engineering.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/bytes.grubhub.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/code.tubitv.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/developers.500px.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/blog.bernd-ruecker.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/engblog.nextdoor.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/engineering.checkr.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/tech.affirm.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/engineering.talkdesk.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/flexport.engineering.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/bytes.swiggy.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.marqeta.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/blog.coinbase.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/blog.gojekengineering.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/blog.discord.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/instagram-engineering.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/itnext.io.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/netflixtechblog.com.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/robinhood.engineering.txt \
 && cp /var/www/wallabag/vendor/j0k3r/graby-site-config/medium.com.txt /var/www/wallabag/vendor/j0k3r/graby-site-config/engineering.pandora.com.txt

COPY site_config/ /var/www/wallabag/vendor/j0k3r/graby-site-config/

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
CMD ["wallabag"]
