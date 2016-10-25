{{ cookiecutter.project_name }} Service
===========================

This is {{ cookiecutter.project_name }} Project.

Setup
-----

Use pyenv_ for local develop. After pyenv is installed.
Please follow below steps to setup development environment.

.. code:: shell

    pyenv install 3.5.2
    pyenv local 3.5.2
    pyenv virtualenv {{ cookiecutter.project_name }}
    pyenv acitve {{ cookiecutter.project_name }}
    make pip-dev
    make test-coverage-ci
    make clean


Test
----

For naive test

.. code:: shell

    make test


Testing with coverage report

.. code:: shell

   make test-coverage-ci

Testing with coverage report and generate html output

.. code:: shell

    make test-covrage && make report-coverage-html


Deploy
------

Package source code into {{ cookiecutter.project_name }}.tar.gz file.

.. code:: shell

    make package-src


Build docker image

.. code:: shell

    make build-image


.. _pyenv: https://github.com/yyuu/pyenv
