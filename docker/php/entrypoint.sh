#!/bin/bash

# Setup user
addgroup --gid $GROUP_ID user
adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

chown -R $USER_ID:$GROUP_ID /var/www && \
cd /var/www/PROJECT_NAME

su user

composer global require statamic/cli

if [ -f "composer.json" ]; then
    composer install -v
fi

if [ -d "storage" ]; then
    chmod -R 777 storage
fi

php-fpm
