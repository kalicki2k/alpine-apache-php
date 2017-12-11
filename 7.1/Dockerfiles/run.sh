#!/bin/sh
#
# Purpose: Starting Apache damon...
# Version: 1.0
#

CGI_PATH=/var/www/localhost/cgi-bin
CONFIG_PATH=/etc/apache2/httpd.conf
DOCUMENT_ROOT=/var/www/localhost/htdocs
LOGS_PATH=/var/www/localhost/logs

#
# Checks if required folder exists. If not, it will be created.
#
if [[ ! -d ${CGI_PATH} ]]
then
    mkdir ${CGI_PATH}
fi

if [[ ! -d ${DOCUMENT_ROOT} ]]
then
    mkdir ${DOCUMENT_ROOT}
fi

if [[ ! -d ${LOGS_PATH} ]]
then
    mkdir ${LOGS_PATH}
fi

#
# Set server name
#
if [[ ! -z ${APACHE_SERVER_NAME} ]]
then
    sed -i "s/ServerName localhost/ServerName ${APACHE_SERVER_NAME}/" ${CONFIG_PATH}
fi

#
# Create user and group
#
if [[ ! -z ${APACHE_RUN_USER} ]]
then

    if [[ -z ${APACHE_RUN_GROUP} ]]
    then
        APACHE_RUN_GROUP=apache
    fi

    sed -i "s/User apache/User ${APACHE_RUN_USER}/" ${CONFIG_PATH}
    sed -i "s/Group apache/Group ${APACHE_RUN_GROUP}/" ${CONFIG_PATH}


    if [[ ! -z ${APACHE_RUN_USER_ID} ]] && [[ ! -z ${APACHE_RUN_GROUP_ID} ]]
    then
        addgroup -g ${APACHE_RUN_GROUP_ID} ${APACHE_RUN_GROUP}
        adduser -u ${APACHE_RUN_USER_ID} -G ${APACHE_RUN_GROUP} -h ${DOCUMENT_ROOT} ${APACHE_RUN_USER}

    else
        addgroup ${APACHE_RUN_GROUP}
        adduser -G ${APACHE_RUN_GROUP} -h ${DOCUMENT_ROOT} ${APACHE_RUN_USER}
    fi

    chown -R ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} ${DOCUMENT_ROOT}
fi

#
# PHP.ini
#
if [[ ! -z "$PHP_SHORT_OPEN_TAG" ]]; then sed -i "s/\;\?\\s\?short_open_tag = .*/short_open_tag = $PHP_SHORT_OPEN_TAG/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_OUTPUT_BUFFERING" ]]; then sed -i "s/\;\?\\s\?output_buffering = .*/output_buffering = $PHP_OUTPUT_BUFFERING/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_OPEN_BASEDIR" ]]; then sed -i "s/\;\?\\s\?open_basedir = .*/open_basedir = $PHP_OPEN_BASEDIR/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_MAX_EXECUTION_TIME" ]]; then sed -i "s/\;\?\\s\?max_execution_time = .*/max_execution_time = $PHP_MAX_EXECUTION_TIME/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_MAX_INPUT_TIME" ]]; then sed -i "s/\;\?\\s\?max_input_time = .*/max_input_time = $PHP_MAX_INPUT_TIME/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_MAX_INPUT_VARS" ]]; then sed -i "s/\;\?\\s\?max_input_vars = .*/max_input_vars = $PHP_MAX_INPUT_VARS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_MEMORY_LIMIT" ]]; then sed -i "s/\;\?\\s\?memory_limit = .*/memory_limit = $PHP_MEMORY_LIMIT/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_ERROR_REPORTING" ]]; then sed -i "s/\;\?\\s\?error_reporting = .*/error_reporting = $PHP_ERROR_REPORTING/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_DISPLAY_ERRORS" ]]; then sed -i "s/\;\?\\s\?display_errors = .*/display_errors = $PHP_DISPLAY_ERRORS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_DISPLAY_STARTUP_ERRORS" ]]; then sed -i "s/\;\?\\s\?display_startup_errors = .*/display_startup_errors = $PHP_DISPLAY_STARTUP_ERRORS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_LOG_ERRORS" ]]; then sed -i "s/\;\?\\s\?log_errors = .*/log_errors = $PHP_LOG_ERRORS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_LOG_ERRORS_MAX_LEN" ]]; then sed -i "s/\;\?\\s\?log_errors_max_len = .*/log_errors_max_len = $PHP_LOG_ERRORS_MAX_LEN/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_IGNORE_REPEATED_ERRORS" ]]; then sed -i "s/\;\?\\s\?ignore_repeated_errors = .*/ignore_repeated_errors = $PHP_IGNORE_REPEATED_ERRORS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_REPORT_MEMLEAKS" ]]; then sed -i "s/\;\?\\s\?report_memleaks = .*/report_memleaks = $PHP_REPORT_MEMLEAKS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_HTML_ERRORS" ]]; then sed -i "s/\;\?\\s\?html_errors = .*/html_errors = $PHP_HTML_ERRORS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_ERROR_LOG" ]]; then sed -i "s/\;\?\\s\?error_log = .*/error_log = $PHP_ERROR_LOG/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_POST_MAX_SIZE" ]]; then sed -i "s/\;\?\\s\?post_max_size = .*/post_max_size = $PHP_POST_MAX_SIZE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_DEFAULT_MIMETYPE" ]]; then sed -i "s/\;\?\\s\?default_mimetype = .*/default_mimetype = $PHP_DEFAULT_MIMETYPE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_DEFAULT_CHARSET" ]]; then sed -i "s/\;\?\\s\?default_charset = .*/default_charset = $PHP_DEFAULT_CHARSET/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_FILE_UPLOADS" ]]; then sed -i "s/\;\?\\s\?file_uploads = .*/file_uploads = $PHP_FILE_UPLOADS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_UPLOAD_TMP_DIR" ]]; then sed -i "s/\;\?\\s\?upload_tmp_dir = .*/upload_tmp_dir = $PHP_UPLOAD_TMP_DIR/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_UPLOAD_MAX_FILESIZE" ]]; then sed -i "s/\;\?\\s\?upload_max_filesize = .*/upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_MAX_FILE_UPLOADS" ]]; then sed -i "s/\;\?\\s\?max_file_uploads = .*/max_file_uploads = $PHP_MAX_FILE_UPLOADS/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_ALLOW_URL_FOPEN" ]]; then sed -i "s/\;\?\\s\?allow_url_fopen = .*/allow_url_fopen = $PHP_ALLOW_URL_FOPEN/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_ALLOW_URL_INCLUDE" ]]; then sed -i "s/\;\?\\s\?allow_url_include = .*/allow_url_include = $PHP_ALLOW_URL_INCLUDE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_DEFAULT_SOCKET_TIMEOUT" ]]; then sed -i "s/\;\?\\s\?default_socket_timeout = .*/default_socket_timeout = $PHP_DEFAULT_SOCKET_TIMEOUT/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_DATE_TIMEZONE" ]]; then sed -i "s/\;\?\\s\?date.timezone = .*/date.timezone = $PHP_DATE_TIMEZONE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_PDO_MYSQL_CACHE_SIZE" ]]; then sed -i "s/\;\?\\s\?pdo_mysql.cache_size = .*/pdo_mysql.cache_size = $PHP_PDO_MYSQL_CACHE_SIZE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_PDO_MYSQL_DEFAULT_SOCKET" ]]; then sed -i "s/\;\?\\s\?pdo_mysql.default_socket = .*/pdo_mysql.default_socket = $PHP_PDO_MYSQL_DEFAULT_SOCKET/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_SAVE_HANDLER" ]]; then sed -i "s/\;\?\\s\?session.save_handler = .*/session.save_handler = $PHP_SESSION_SAVE_HANDLER/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_SAVE_PATH" ]]; then sed -i "s/\;\?\\s\?session.save_path = .*/session.save_path = $PHP_SESSION_SAVE_PATH/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_USE_STRICT_MODE" ]]; then sed -i "s/\;\?\\s\?session.use_strict_mode = .*/session.use_strict_mode = $PHP_SESSION_USE_STRICT_MODE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_USE_COOKIES" ]]; then sed -i "s/\;\?\\s\?session.use_cookies = .*/session.use_cookies = $PHP_SESSION_USE_COOKIES/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_COOKIE_SECURE" ]]; then sed -i "s/\;\?\\s\?session.cookie_secure = .*/session.cookie_secure = $PHP_SESSION_COOKIE_SECURE/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_NAME" ]]; then sed -i "s/\;\?\\s\?session.name = .*/session.name = $PHP_SESSION_NAME/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_COOKIE_LIFETIME" ]]; then sed -i "s/\;\?\\s\?session.cookie_lifetime = .*/session.cookie_lifetime = $PHP_SESSION_COOKIE_LIFETIME/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_COOKIE_PATH" ]]; then sed -i "s/\;\?\\s\?session.cookie_path = .*/session.cookie_path = $PHP_SESSION_COOKIE_PATH/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_COOKIE_DOMAIN" ]]; then sed -i "s/\;\?\\s\?session.cookie_domain = .*/session.cookie_domain = $PHP_SESSION_COOKIE_DOMAIN/" /etc/php7/php.ini; fi
if [[ ! -z "$PHP_SESSION_COOKIE_HTTPONLY" ]]; then sed -i "s/\;\?\\s\?session.cookie_httponly = .*/session.cookie_httponly = $PHP_SESSION_COOKIE_HTTPONLY/" /etc/php7/php.ini; fi

#
# Make sure we're not confused by old, incompletely-shutdown httpd context after restarting the container.
# httpd won't start correctly if it thinks it is already running.
#
rm -rf /run/apache2/*

#
# Starting Apache daemon...
#
exec /usr/sbin/httpd -D FOREGROUND
