# Apache with PHP on Alpine Linux 3.6

This is a docker images with Apache2 and PHP7.1 / Composer based on Alpine Linux 3.6.

To access site contents from outside the container you should map `/var/www/localhost/htdocs`.

Includes composer for easy download of php libraries.

## Examples
- plain, accessible on port 8080 `docker run -d -p 8080:80 kalicki2k/alpine-apache-php:7.1`
- with external contents in /home/kalicki2k/html `docker run -d -p 8080:80 -v /path/to/localhost:/var/www/localhost/htdocs kalicki2k/alpine-apache-php:7.1`

The docker container is started with the -d flag so it will run into the background. To run commands or edit settings inside
the container run `docker exec -ti <container id> /bin/bash'
