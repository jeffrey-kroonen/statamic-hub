#!/bin/bash

read -p "What is your project called: " project_name
read -p "Email of superuser: " email

# Stop and remove all docker containers from system
if [[ $(docker ps -q) ]]; then
    docker stop $(docker ps -aq) && docker rm $(docker ps -a -q)
    printf "All docker containers are stopped and removed successfully!\n"
fi

# Make project name snake case and remove special characters
project_name=$(echo "$project_name" | tr -dc '[:alnum:] ' | tr '[:upper:]' '[:lower:]')
project_name="${project_name// /_}"

if [[ "$OSTYPE" == "darwin"* ]]; then
    sedFlags="-i \"\" -e"
else
    sedFlags="-i"
fi

# Replace placeholders in files with given project name
sed $sedFlags "s/PROJECT_NAME/$project_name/" ./docker/nginx/templates/default.conf.template
sed $sedFlags "s/PROJECT_NAME/$project_name/" ./docker/php/Dockerfile
sed $sedFlags "s/PROJECT_NAME/$project_name/" ./docker/php/entrypoint.sh
sed $sedFlags "s/PROJECT_NAME/$project_name/" ./docker-compose.yml
printf "Project name has been processed in necessary files 📂\n"

sed $sedFlags "s/USER_ID: USER_ID/USER_ID: $(id -u)/" ./docker-compose.yml
sed $sedFlags "s/GROUP_ID: GROUP_ID/GROUP_ID: $(id -g)/" ./docker-compose.yml
printf "User information is processed in necessary file 🙆‍♂️\n\n"

cp ./docker/.env.example ./docker/.env

docker-compose build --no-cache && \
docker-compose up -d

sleep 5

# Create statamic project 🚀
docker-compose exec -w /var/www/$project_name app bash -c "printf '0\n' | ~/.composer/vendor/bin/statamic new ."

docker-compose down && \
docker-compose up -d

# Create superuser
docker-compose exec app bash -c "printf '$email\nadmin\npassword\nyes' | php please make:user"

# Done! 🎉
clear
printf "Your project succesfully initialized! 🎉\nGet some coffee, you badass\n\n"
printf "URL: http://cms.$project_name.local:8080/cp\n"
printf "Email: $email\n"
printf "Password: password\n\n"
