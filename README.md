## DEPLOYING WORDPRESS AS A MULTI-CONTAINER APPLICATION USE ANSIBLE  

This repository contains configuration files for our multi-container application.  
---
### Folders

Folder [templates](https://github.com/ausard/ansible_wordpress_docker/tree/master/templates) contains the  template config files of the containers.  

---  

File  [Dockerfile](hhttps://github.com/ausard/ansible_wordpress_docker/blob/master/php/Dockerfile) in folder [php](https://github.com/ausard/ansible_wordpress_docker/tree/master/php) - file for build php image  

---

Folder [tasks](https://github.com/ausard/ansible_wordpress_docker/tree/master/tasks) - main tasks deploying


.env : file contains variables for docker-compose file

Jenkinsfile : files for pipeline job in Jenkins  


### docker-compose.yml - YAML file to configure our application’s services :  

#### Service database management system to store and manage the data for our site: mysql
```
db:
    image: mysql:${MYSQL_VERSION:-latest}
    container_name: db
    restart: always
    env_file: .env
    volumes:
      - dbdata:/var/lib/mysql
    command: '--default-authentication-plugin=mysql_native_password'
    networks:
      - wp_network
```
#### Service PHP-FPM is an implementation of Fast-CGI for PHP with improved capabilities around process management, logging, and high traffic situations:
```
php-fpm:
    build:
      context: ./php
      dockerfile: Dockerfile
      args:
        - PHP_VERSION=${PHP_VERSION:-php:7.4-fpm}      
    container_name: php-fpm    
    volumes:
      - ${wp_volume}:/var/www/html
    depends_on:
      - db
    networks:
      - wp_network
    restart: always
```
#### Service nginx:  send requests for .php routes to PHP-FPM to serve the page.
```
nginx:
    depends_on:
      - php-fpm
    image: nginx:${NGINX_VERSION:-latest}
    container_name: nginx
    restart: always
    ports:
      - "8082:80"
    volumes:
      - ${wp_volume}:/var/www/html      
      - ./nginx-conf/nginx.conf:/etc/nginx/conf.d/default.conf
    networks:
      - wp_network
    links:
      - php-fpm
```
