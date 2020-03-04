## DEPLOYING WORDPRESS AS A MULTI-CONTAINER APPLICATION USE ANSIBLE  

This repository contains configuration files for our multi-container application.  
---
### Folders

Folder [templates](https://github.com/ausard/EP-wp-ansible/tree/master/templates) contains the  template config files of the containers.  

---  

File  [Dockerfile](hhttps://github.com/ausard/EP-wp-ansible/blob/master/php/Dockerfile) in folder [php](https://github.com/ausard/EP-wp-ansible/tree/master/php) - file for build php image  

---

Folder [tasks](https://github.com/ausard/EP-wp-ansible/tree/master/tasks) - main tasks deploying


Jenkinsfile : file for pipeline job in Jenkins  


### tasks/build_docker_containers.yml -  file to configure our application’s services :  

#### Service database management system to store and manage the data for our site: mysql
```
- name: Launch database container
  docker_container:
    name: "{{ db_name }}"
    image: mysql:{{ MYSQL_VERSION }}
    restart: yes
    detach: yes
    state: started
    env:
      MYSQL_ROOT_PASSWORD: "{{ MYSQL_ROOT_PASSWORD }}"
      MYSQL_USER: "{{ MYSQL_USER }}"
      MYSQL_PASSWORD: "{{ MYSQL_PASSWORD }}"
      MYSQL_DATABASE: "{{ MYSQL_DATABASE }}"
    volumes:
      - "{{ db_volume }}:/var/lib/mysql"
    command: --default-authentication-plugin=mysql_native_password
    network_mode: "{{ docker_network }}"

```
#### Service PHP-FPM is an implementation of Fast-CGI for PHP with improved capabilities around process management, logging, and high traffic situations:
```
- name: Launch php container
  docker_container:
    name: "{{ php_name }}"
    image: "{{ php_name }}"
    restart: yes
    volumes:
      - "{{ wp_volume }}/wordpress:/var/www/html"
    network_mode: "{{ docker_network }}"
    state: started
```
#### Service nginx:  send requests for .php routes to PHP-FPM to serve the page.
```
name: Launch nginx container
 docker_container:
   name: "{{ nginx_name }}"
   image: nginx:{{ NGINX_VERSION }}
   restart: yes
   volumes:
     - "{{ wp_volume }}/wordpress:/var/www/html"
     - "./nginx.conf:/etc/nginx/conf.d/default.conf"
   ports:
     - "8082:80"
   links:
     - "{{ php_name }}"
   network_mode: "{{ docker_network }}"
   state: started
```
