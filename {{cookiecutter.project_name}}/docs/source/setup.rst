Setup and Install
=================

*For developer*

This document describe how to setup local development in details.

We provide several ways to setup your development stack:

* Localhost bare metal stack
* Docker and docker compose

To run this project, correct config is important, please check carefully when you fail testing or local run.

Localhost stack
---------------

This is probably the most familiar ane easy way to all developers, and totally **mannual** (you can also use makefile if you familiar with it).
Please install following software and tool on your localhost directly

* python3.5.2 (recommend to install with pyenv_ or virtualenv_)
* pip_
* mysql_
* memcached_
* redis_

.. _pyenv: https://github.com/yyuu/pyenv
.. _virtualenv: https://virtualenv.pypa.io/en/stable/
.. _pip: https://pypi.python.org/pypi/pip
.. _mysql: http://www.mysql.com
.. _memcached: https://memcached.org
.. _redis: https://redislabs.com


After above softwares are installed and served properly, you've completed your development stack.
OK, we can only take care about python and shell thing from now on.

Django dev
~~~~~~~~~~

1. Next, navigate to project root and install the essential python packages 

   .. code:: shell

       pip install -r requirements/develop.txt

2. Export environment variables to your shell/workspace 

   .. code:: shell

      source scripts/local-env.sh

3. Now it's time for Django works:

   * go to your Django root, the folder with `manage.py`
   * generate migrations if needed

     .. code:: shell

         ./manage.py makemigrations
   * perform quick test to verify and validate including: python, python-packages, django-settings

     .. code:: shell

        ./manage.py test --settings={{cookiecutter.project_name}}.settings.quick_test
   * perform migrate

     .. code:: shell

        ./manage.py migrate

   * run your django server on localhost

     .. code:: shell

        ./manage.py runserver
4. Visit site at http://localhost:8080

Docker setup
------------

This is a container-supported way to config developement stack, please install Docker_ and docker-compose_.
* Go to your project root and built base image with `docker built -t py_{{cookiecutter.project_name}}_prod docker/prod_base`
* Then run `docker-compose -f compose-local.yml up -d`
* If no error occured, you can visit http://localhost:80 through nginx, or http://localhost:9528 through uwsgi

.. _Docker: https://www.docker.com
.. _docker-compose: https://docs.docker.com/compose/


Happy coding !!!
