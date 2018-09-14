FROM kalicki2k/alpine-apache:2.4.34

MAINTAINER Sebastian Kalicki (https://github.com/kalicki2k)

COPY Dockerfiles/. /

RUN apk update && apk upgrade && \
    apk add curl mysql-client \
            php5 php5-cli php5-apache2 php5-bcmath php5-ctype php5-curl php5-dom php5-gd php5-iconv php5-intl \
            php5-json php5-mcrypt php5-mysql php5-mysqli php5-imap php5-opcache php5-pgsql php5-pdo php5-pdo_mysql php5-phar \
            php5-openssl php5-soap php5-sqlite3 php5-xml php5-xmlrpc php5-xmlreader php5-xsl php5-zip php5-zlib && \
    curl -sS https://getcomposer.org/installer | php5 -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /run.sh && \
    rm -rf /var/www/localhost/htdocs/index.html && \
    rm -rf /var/cache/apk/*

WORKDIR /var/www/localhost

EXPOSE 80 443

ENTRYPOINT ["/run.sh"]