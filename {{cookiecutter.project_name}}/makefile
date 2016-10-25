CC=python manage.py
DJ_SRC={{ cookiecutter.project_name }}
PWD=$(shell pwd)

build:
	echo "No build"
pip:
	pip install -r requirements.txt
pip-dev:
	pip install -r requirements/develop.txt
pip-report:
	pip install -r requirements/report.txt
install:
	make pip && \
		cd ${DJ_SRC} && \
		$(CC) makemigrations && \
		$(CC) migrate && \
		$(CC) collectstatic -l
		# $(CC) compilemessags
test-coverage-ci:
	make pip-dev && \
		cd ${DJ_SRC} &&  \
		coverage run -a --source=. manage.py test
test:
	cd ${DJ_SRC} &&  \
	$(CC) test
test-coverage:
	cd ${DJ_SRC} &&  \
	coverage run --source=. manage.py test && \
	coverage report -m
report-coverage-html:
	make pip-report && \
		cd ${DJ_SRC} && coverage html -d ../covr

package-src:
	rm -f /tmp/${DJ_SRC}.tar.gz ${DJ_SRC}.tar.gz && \
		tar --exclude-from=.gitignore --exclude=.git* . -czf /tmp/${DJ_SRC}.tar.gz && \
		mv /tmp/${DJ_SRC}.tar.gz . && \

build-image:
	make package-src && \
		docker build --force-rm -t ${IMAGE_TAG} .

clean:
	find . -name \*.pyc -delete && \
		find . -name \*,cover -delete && \
		find . -name \*.sqlite3 -delete
