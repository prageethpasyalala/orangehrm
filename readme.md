```# Use an official PHP image as the base
FROM php:8.1-apache

# Install required PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libicu-dev \
    libjpeg-dev \
    libpng-dev \
    libldap2-dev \
    unzip \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install \
    zip \
    intl \
    gd \
    ldap \
    && docker-php-ext-enable \
    zip \
    intl \
    gd \
    ldap

# Enable any required modules (if applicable)
RUN a2enmod rewrite
```

docker build -t my-php-app .
docker stop my-app-container
docker rm my-app-container
docker run -d -p 8080:80 --name my-app-container my-php-app
