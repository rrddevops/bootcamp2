# 1 Set master image
FROM php:7.2-apache

# 2 Set working directory
WORKDIR /var/www/html

COPY app/ .

# 10 Expose port 80
EXPOSE 9000
