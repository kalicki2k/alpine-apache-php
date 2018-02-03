#!/bin/sh
#
# Version: 1.0
# Purpose:
#   - Creating required folder and setup error pages for Apache
#   - Setting environments for Apache
#   - Starting Apache damon
#

CGI_PATH=/var/www/localhost/cgi-bin
CONFIG_PATH=/etc/apache2/httpd.conf
DOCUMENT_ROOT=/var/www/localhost/htdocs
DOCUMENT_SKEL_ROOT=/var/www/skel/htdocs
LOGS_PATH=/var/www/localhost/logs
ERROR_PATH=/var/www/localhost/error
ERROR_SKEL_PATH=/var/www/skel/error

#
# Checks if required folder exists. If not, it will be created.
#
if [[ ! -d ${CGI_PATH} ]]; then
    mkdir ${CGI_PATH}
fi

if [[ ! -d ${DOCUMENT_ROOT} ]]; then
    cp -r ${DOCUMENT_SKEL_ROOT} ${DOCUMENT_ROOT}
fi

if [[ ! -d ${LOGS_PATH} ]]; then
    mkdir ${LOGS_PATH}
fi

if [[ ! -d ${ERROR_PATH} ]]; then
    cp -r ${ERROR_SKEL_PATH} ${ERROR_PATH}
fi

#
# Set server name
#
if [[ ! -z ${APACHE_SERVER_NAME} ]]; then
    sed -i "s/ServerName localhost/ServerName ${APACHE_SERVER_NAME}/" ${CONFIG_PATH}
fi

#
# Create user and group
#
if [[ ! -z ${APACHE_RUN_USER} ]]; then

    if [[ -z ${APACHE_RUN_GROUP} ]]; then
        APACHE_RUN_GROUP=apache
    fi

    sed -i "s/User apache/User ${APACHE_RUN_USER}/" ${CONFIG_PATH}
    sed -i "s/Group apache/Group ${APACHE_RUN_GROUP}/" ${CONFIG_PATH}


    if [[ ! -z ${APACHE_RUN_USER_ID} ]] && [[ ! -z ${APACHE_RUN_GROUP_ID} ]]; then
        addgroup -g ${APACHE_RUN_GROUP_ID} ${APACHE_RUN_GROUP}
        adduser -u ${APACHE_RUN_USER_ID} -G ${APACHE_RUN_GROUP} -h ${DOCUMENT_ROOT} ${APACHE_RUN_USER}

    else
        addgroup ${APACHE_RUN_GROUP}
        adduser -G ${APACHE_RUN_GROUP} -h ${DOCUMENT_ROOT} ${APACHE_RUN_USER}
    fi

else
    APACHE_RUN_USER=apache
    APACHE_RUN_GROUP=apache
fi

chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} ${DOCUMENT_ROOT}

#
# Make sure we're not confused by old, incompletely-shutdown httpd context after restarting the container.
# httpd won't start correctly if it thinks it is already running.
#
rm -rf /run/apache2/*

#
# Starting Apache daemon...
#
exec /usr/sbin/httpd -D FOREGROUND
