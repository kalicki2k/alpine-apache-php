# Apache with PHP on Alpine Linux 3.6

This is a docker images with Apache and PHP / Composer based on Alpine Linux.

To access site contents from outside the container you should map `/var/www/localhost/htdocs`.

Includes composer for easy download of php libraries.

## Static folders
The image exposes a volume at `/var/www/localhost`. The structure is:

| Directory                  | Description    |
| -------------------------- | -------------- |
| /var/www/localhost/htdocs  | web root       |
| /var/www/localhost/cgi-bin | cgi bin folder |
| /var/www/localhost/logs    | log folder     |
| /var/www/localhost/error   | error pages    |

## Environment variables
Various env vars can be set at runtime via your docker command or docker-compose environment section.

### Apache
| Name                         | Description                                                     |
| ---------------------------- | --------------------------------------------------------------- |
| APACHE_SERVER_NAME           | Server name that the server uses to identify itself.            |
| APACHE_SERVER_MAIL           | Your address, where problems with the server should be e-mailed |
| APACHE_RUN_USER              | User name to run httpd as.                                      |
| APACHE_RUN_USER_ID           | User ID to run httpd as.                                        |
| APACHE_RUN_GROUP             | Group name to run httpd as.                                     |
| APACHE_RUN_GROUP_ID          | Group ID to run httpd as.                                       |
| APACHE_SSL_CERTIFICATE       | Server Certificate...                                           |
| APACHE_SSL_CERTIFICATE_KEY   | Server Private Key...                                           |
| APACHE_SSL_CERTIFICATE_CHAIN | Server Certificate Chain...                                     |
| APACHE_WEB_ROOT              |                                                                 |

### PHP
| Name                         | Default                           | Description                                                                                                                                                                                                                                                                   |
| ---------------------------- | --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| PHP_SHORT_OPEN_TAG           | Off                               | Tells PHP whether the short form `<? ?>` of PHP's open tag should be allowed. (See: http://php.net/short-open-tag)                                                                                                                                                            |
| PHP_OUTPUT_BUFFERING         | 4096                              | You can enable output buffering for all files by setting this directive to 'On'. If you wish to limit the size of the buffer to a certain size - you can use a maximum number of bytes instead of 'On', as a value for this directive. (See: http://php.net/output-buffering) |
| PHP_OPEN_BASEDIR             |                                   | Limit the files that can be accessed by PHP to the specified directory-tree, including the file itself. (See: http://php.net/open-basedir)                                                                                                                                    |
| PHP_MAX_EXECUTION_TIME       | 30                                | This sets the maximum time in seconds a script is allowed to run before it is terminated by the parser. (See: http://php.net/max-execution-time)                                                                                                                              |
| PHP_MAX_INPUT_TIME           | 60                                | This sets the maximum time in seconds a script is allowed to parse input data, like POST and GET. (See: http://php.net/max-input-time)                                                                                                                                        |
| PHP_MAX_INPUT_VARS           | 1000                              | How many input variables may be accepted (limit is applied to $_GET, $_POST and $_COOKIE superglobal separately). (See: http://php.net/manual/en/info.configuration.php#ini.max-input-vars)                                                                                   |
| PHP_MEMORY_LIMIT             | 128M                              | This sets the maximum amount of memory in bytes that a script is allowed to allocate. (See: http://php.net/memory-limit)                                                                                                                                                      |
| PHP_ERROR_REPORTING          | E_ALL & ~E_DEPRECATED & ~E_STRICT | Set the error reporting level. (See: http://php.net/error-reporting)                                                                                                                                                                                                          |
| PHP_DISPLAY_ERRORS           | Off                               | This determines whether errors should be printed to the screen as part of the output or if they should be hidden from the user. (See: http://php.net/display-errors)                                                                                                          |
| PHP_DISPLAY_STARTUP_ERRORS   | Off                               | Even when display_errors is on, errors that occur during PHP's startup sequence are not displayed. (See: http://php.net/display-startup-errors)                                                                                                                               |
| PHP_LOG_ERRORS               | On                                | Tells whether script error messages should be logged to the server's error log. (See: http://php.net/log-errors)                                                                                                                                                              |
| PHP_LOG_ERRORS_MAX_LEN       | 1024                              | Set the maximum length of log_errors in bytes. (See: http://php.net/log-errors-max-len)                                                                                                                                                                                       |
| PHP_IGNORE_REPEATED_ERRORS   | Off                               | Do not log repeated messages. (See: http://php.net/ignore-repeated-errors)                                                                                                                                                                                                    |
| PHP_REPORT_MEMLEAKS          | On                                | This parameter will show a report of memory leaks detected by the Zend memory manager. (See: http://php.net/report-memleaks)                                                                                                                                                  |
| PHP_HTML_ERRORS              | On                                | If enabled, error messages will include HTML tags. (See: http://php.net/html-errors)                                                                                                                                                                                          |
| PHP_ERROR_LOG                |                                   | Name of the file where script errors should be logged. (See: http://php.net/error-log)                                                                                                                                                                                        |
| PHP_POST_MAX_SIZE            | 8M                                | Sets max size of post data allowed. (See: http://php.net/post-max-size)                                                                                                                                                                                                       |
| PHP_DEFAULT_MIMETYPE         | text/html                         | By default, PHP will output a media type using the Content-Type header. (See: http://php.net/default-mimetype)                                                                                                                                                                |
| PHP_DEFAULT_CHARSET          | UTF-8                             | Default character encoding... (See: http://php.net/default-charset)                                                                                                                                                                                                           |
| PHP_FILE_UPLOADS             | On                                | Whether to allow HTTP file uploads. (See: http://php.net/file-uploads)                                                                                                                                                                                                        |
| PHP_UPLOAD_TMP_DIR           |                                   | The temporary directory used for storing files when doing file upload. (See: http://php.net/upload-tmp-dir)                                                                                                                                                                   |
| PHP_UPLOAD_MAX_FILESIZE      | 2M                                | The maximum size of an uploaded file. (See: http://php.net/upload-max-filesize)                                                                                                                                                                                               |
| PHP_ALLOW_URL_FOPEN          | On                                | This option enables the URL-aware fopen wrappers that enable accessing URL object like files. (See: http://php.net/allow-url-fopen)                                                                                                                                           |
| PHP_ALLOW_URL_INCLUDE        | Off                               | This option allows the use of URL-aware fopen wrappers with the following functions: include, include_once, require, require_once. (See: http://php.net/allow-url-include)                                                                                                    |
| PHP_DEFAULT_SOCKET_TIMEOUT   | 60                                | Default timeout (in seconds) for socket based streams. (See: http://php.net/default-socket-timeout)                                                                                                                                                                           |
| PHP_DATE_TIMEZONE            | Europe/Berlin                     | Defines the default timezone used by the date functions. (See: http://php.net/date.timezone)                                                                                                                                                                                  |
| PHP_PDO_MYSQL_CACHE_SIZE     | 2000                              | If mysqlnd is used: Number of cache slots for the internal result set cache. (See: http://php.net/pdo_mysql.cache_size)                                                                                                                                                       |
| PHP_PDO_MYSQL_DEFAULT_SOCKET |                                   | Default socket name for local MySQL connects. (See: http://php.net/pdo_mysql.default-socket)                                                                                                                                                                                  |
| PHP_SESSION_SAVE_HANDLER     | files                             | Handler used to store/retrieve data. (See: http://php.net/session.save-handler)                                                                                                                                                                                               |
| PHP_SESSION_SAVE_PATH        | /tmp                              | In the case of files, this is the path where data files are stored. (See: http://php.net/session.save-path)                                                                                                                                                                   |
| PHP_SESSION_USE_STRICT_MODE  | 0                                 | Whether to use strict session mode. (See: https://wiki.php.net/rfc/strict_sessions)                                                                                                                                                                                           |
| PHP_SESSION_USE_COOKIES      | 1                                 | Whether to use cookies. (See: http://php.net/session.use-cookies)                                                                                                                                                                                                             |
| PHP_SESSION_COOKIE_SECURE    |                                   | Specifies whether cookies should only be sent over secure connections. (See: http://php.net/session.cookie-secure)                                                                                                                                                            |
| PHP_SESSION_NAME             | PHPSESSID                         | Name of the session (used as cookie name). (See: http://php.net/session.name)                                                                                                                                                                                                 |
| PHP_SESSION_COOKIE_LIFETIME  | 0                                 | Lifetime in seconds of cookie or, if 0, until browser is restarted. (See: http://php.net/session.cookie-lifetime)                                                                                                                                                             |
| PHP_SESSION_COOKIE_PATH      | /                                 | The path for which the cookie is valid. (See: http://php.net/session.cookie-path)                                                                                                                                                                                             |
| PHP_SESSION_COOKIE_DOMAIN    |                                   | The domain for which the cookie is valid. (See: http://php.net/session.cookie-domain)                                                                                                                                                                                         |
| PHP_SESSION_COOKIE_HTTPONLY  |                                   | Whether or not to add the httpOnly flag to the cookie, which makes it inaccessible to browser scripting languages such as JavaScript. (See: http://php.net/session.cookie-httponly)                                                                                           |

### Additional environment variables
| Name             | Default | Description                                          |
| ---------------- | ------- | ---------------------------------------------------- |
| PUBLIC_DIRECTORY |         | The public directory contains the `index.php` file, which is the entry point for all requests entering your application. |

## Examples
- plain, accessible on port 8080 `docker run -d -p 8080:80 kalicki2k/alpine-apache-php:7.2`
- with external contents in /home/kalicki2k/html `docker run -d -p 8080:80 -v /home/kalicki2k/html:/var/www/localhost kalicki2k/alpine-apache-php:7.2`

The docker container is started with the -d flag so it will run into the background. To run commands or edit settings inside
the container run `docker exec -ti <container id> /bin/bash'
