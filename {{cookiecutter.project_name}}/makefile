.PHONY: help clean
CC=python manage.py
DJ_SRC={{ cookiecutter.project_name }}
PWD=$(shell pwd)

help:
	scripts/cmd.sh -h
install-pip:
	scripts/cmd.sh install-pip
install-pip-dev:
	scripts/cmd.sh install-pip-dev
install-pip-rep:
	scripts/cmd.sh install-pip-rep
install-dj:
	scripts/cmd.sh install-dj
test-coverage:
	scripts/cmd.sh test-coverage
test-coverage-quick:
	scripts/cmd.sh test-coverage-quick
test-coverage-html:
	scripts/cmd.sh test-coverage-html
package-src:
	scripts/cmd.sh package-src
clean:
	scripts/cmd.sh clean
build-base-image:
	scripts/cmd.sh build-base-image
start-local:
	scripts/cmd.sh start-local
build-image:
	make package-src && \
		docker build --force-rm -t ${IMAGE_TAG} .
