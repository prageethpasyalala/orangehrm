# Use an official PHP image with Apache
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

# Set environment variables to disable interactive prompts during Docker build
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the application code from the host machine to the container
COPY ./orangehrm-57 /var/www/html

# Set proper permissions for the application
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 to make the application accessible
EXPOSE 80
