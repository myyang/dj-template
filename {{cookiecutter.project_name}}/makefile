.PHONY: help clean test
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
test:
	scripts/cmd.sh test
test-quick:
	scripts/cmd.sh test-quick
test-coverage:
	scripts/cmd.sh test-coverage
test-coverage-html:
	scripts/cmd.sh test-coverage-html
test-coverage-quick:
	scripts/cmd.sh test-coverage-quick
package-prod-src:
	scripts/cmd.sh package-prod-src
package-staging-src:
	scripts/cmd.sh package-staging-src
clean:
	scripts/cmd.sh clean
build-base-image:
	scripts/cmd.sh build-base-image
start-local:
	scripts/cmd.sh build-base-image
	scripts/cmd.sh start-local
start-staging:
	scripts/cmd.sh build-base-image
	scripts/cmd.sh start-staging
stop-and-clean-staging:
	scripts/cmd.sh stop-and-clean-staging
setup-local-env:
	scripts/local-env.sh
build-image:
	make package-prod-src && \
		docker build --force-rm -t ${IMAGE_TAG} .
