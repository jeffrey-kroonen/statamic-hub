FROM php:8.1.4-fpm

# Install linux packages
RUN apt-get update -y && \
    apt-get install \
        libssl-dev \
        libzip-dev \
        libpng-dev \
        zip \
        git \
        unzip \
        -y

# configure and install php packages
RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && \
    docker-php-ext-configure zip && \
    docker-php-ext-install -j "$(nproc)" \
    pdo \
    pdo_mysql \
    zip \
    bcmath \
    exif \
    gd

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/PROJECT_NAME
