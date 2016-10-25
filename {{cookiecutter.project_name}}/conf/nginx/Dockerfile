from nginx:alpine

maintainer {{ cookiecutter.author_name }}

copy nginx.conf /etc/nginx/
copy default.tpl /etc/nginx/conf.d/

add start-service.sh /

cmd ["./start-service.sh"]
