#!/bin/bash
#
# Version: 1.1
# Purpose:
#   - Creating required directories
#   - Creating error pages
#   - Creating default index.html
#   - Setting server name
#   - Setting user and group
#   - Setting SSL/TLS Certificate
#   - Starting Apache damon
#

ERROR=/error
HTDOCS=/htdocs
APACHE_ROOT=/etc/apache2/
SERVER_ROOT=/var/www/localhost
TEMPLATE_ROOT=/var/www/skel

DIRECTORIES=(/cgi-bin ${HTDOCS} /logs ${ERROR})

#
# Checks if required folder exists. If not, it will be created.
#
function create_directories {
    for DIRECTORY in ${DIRECTORIES[@]}; do
        DIRECTORY_PATH="${SERVER_ROOT}${DIRECTORY}"
        if [ ! -d ${DIRECTORY_PATH} ]; then
            mkdir ${DIRECTORY_PATH}
            echo "Created directory ${DIRECTORY}"
        fi
    done
}

#
# Check if error folder is empty. If not, it will create error pages.
#
function create_error_pages {
    if [ ! "$(ls -A "${SERVER_ROOT}${ERROR}")" ]; then
        cp -r ${TEMPLATE_ROOT}${ERROR} ${SERVER_ROOT}${ERROR}
        echo "Created error pages.";
    fi
}

function create_web_page {
    if grep -q "It works!" ${SERVER_ROOT}${HTDOCS}/index.html; then
        cp ${TEMPLATE_ROOT}${HTDOCS}/index.html ${SERVER_ROOT}${HTDOCS}/index.html
        echo "Created default web pages.";
    fi
}

function set_server_name {
    if [ ! -z ${APACHE_SERVER_NAME} ]; then
        sed -i "s/ServerName www.example.com:80/ServerName ${APACHE_SERVER_NAME}:80/" ${APACHE_ROOT}/httpd.conf
        sed -i "s/ServerName www.example.com:443/ServerName ${APACHE_SERVER_NAME}:443/" ${APACHE_ROOT}/conf.d/ssl.conf
        echo "Set server name to ${APACHE_SERVER_NAME}."
    fi
}

function set_user_and_group {
    if [ ! -z ${APACHE_RUN_USER} ]; then

         if [ -z ${APACHE_RUN_GROUP} ]; then
            APACHE_RUN_GROUP=apache
        fi

        sed -i "s/User apache/User ${APACHE_RUN_USER}/" ${APACHE_ROOT}/httpd.conf
        sed -i "s/Group apache/Group ${APACHE_RUN_GROUP}/" ${APACHE_ROOT}/httpd.conf


        if [ ! -z ${APACHE_RUN_USER_ID} ] && [ ! -z ${APACHE_RUN_GROUP_ID} ]; then
            addgroup -g ${APACHE_RUN_GROUP_ID} ${APACHE_RUN_GROUP} > /dev/null 2>&1
            adduser -u ${APACHE_RUN_USER_ID} -G ${APACHE_RUN_GROUP} -h ${SERVER_ROOT} ${APACHE_RUN_USER} > /dev/null 2>&1

        else
            addgroup ${APACHE_RUN_GROUP} > /dev/null 2>&1
            adduser -G ${APACHE_RUN_GROUP} -h ${SERVER_ROOT} ${APACHE_RUN_USER} > /dev/null 2>&1
        fi

        chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} ${SERVER_ROOT}/${HTDOCS}
        echo "Created apache user and group."
    fi
}

function set_ssl {
    if [[ -n ${APACHE_SSL_CERTIFICATE} && -n ${APACHE_SSL_CERTIFICATE_KEY} && -n ${APACHE_SSL_CERTIFICATE_CHAIN} ]] ; then
        sed -i -e "s/SSLCertificateChainFile .*/SSLCertificateChainFile ${APACHE_SSL_CERTIFICATE_CHAIN//\//\\/}/" -e "s/#SSLCertificateChainFile/SSLCertificateChainFile/" ${APACHE_ROOT}/conf.d/ssl.conf
        echo "Set SSLCertificateChainFile to ${APACHE_SSL_CERTIFICATE_CHAIN}"
    fi

    if [[ -n ${APACHE_SSL_CERTIFICATE} && -n ${APACHE_SSL_CERTIFICATE_KEY} ]] ; then
        sed -i -e "s/SSLCertificateFile .*/SSLCertificateFile ${APACHE_SSL_CERTIFICATE//\//\\/}/" -e "s/#SSLCertificateFile/SSLCertificateFile/" ${APACHE_ROOT}/conf.d/ssl.conf
        sed -i -e "s/SSLCertificateKeyFile .*/SSLCertificateKeyFile ${APACHE_SSL_CERTIFICATE_KEY//\//\\/}/" -e "s/#SSLCertificateKeyFile/SSLCertificateKeyFile/" ${APACHE_ROOT}/conf.d/ssl.conf
        echo "Set SSLCertificateFile to ${APACHE_SSL_CERTIFICATE}"
        echo "Set SSLCertificateKeyFile to ${APACHE_SSL_CERTIFICATE_KEY}"
    fi
}

#
# Make sure we're not confused by old, incompletely-shutdown httpd context after restarting the container.
# httpd won't start correctly if it thinks it is already running.
#
function clean {
    rm -rf /run/apache2/*
}

#
# Starting Apache daemon...
#
function run {
    exec /usr/sbin/httpd -D FOREGROUND
}

create_directories
create_error_pages
create_web_page

set_server_name
set_user_and_group
set_ssl

clean
run
