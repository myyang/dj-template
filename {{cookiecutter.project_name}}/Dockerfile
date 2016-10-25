from python:3.5.2-alpine

maintainer {{ cookiecutter.author_email }}

env DJANGO_SETTINGS_MODULE {{ cookiecutter.project_name }}.settings.production
env WORKSPACE /sources

workdir ${WORKSPACE}

add {{ cookiecutter.project_name }}.tar.gz ${WORKSPACE}

run make pip

expose 9527 9528

cmd ["./start-service.sh"]
