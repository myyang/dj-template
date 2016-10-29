{{ cookiecutter.project_name }} Service
===========================

This is {{ cookiecutter.project_name }} Project.

Setup
-----

Use pyenv_ for local develop. After pyenv is installed.
Please follow below steps to setup development environment on local machine.

.. code:: shell

    pyenv install 3.5.2
    pyenv local 3.5.2
    pyenv virtualenv {{ cookiecutter.project_name }}
    pyenv activate {{ cookiecutter.project_name }}
    make pip-dev
    make test-coverage
    make clean

Optionally, you may create local development stack with docker-compose by using:

.. code:: shell

    make start-local

Test
----

Testing with coverage report

.. code:: shell

   make test-coverage

Testing with coverage report and generate html output

.. code:: shell

    make test-covrage-html


Deploy
------

Package source code into {{ cookiecutter.project_name }}.tar.gz file.

.. code:: shell

    make package-src


Build docker image

.. code:: shell

    make build-image


.. _pyenv: https://github.com/yyuu/pyenv
