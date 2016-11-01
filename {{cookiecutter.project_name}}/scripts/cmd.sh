#!/bin/sh

__ScriptVersion="1"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
usage ()
{
    echo "Usage :  $0 [options] COMMAND 

    This is script for makefile concrete commands.

    Commands:
    install-pip         Install production python dependancy
    install-pip-dev     Install development python dependancy
    install-pip-rep     Install report
    install-dj          Perform Django commands
    test-coverage       Perform Django test commands and report test coverage
    test-coverage-html  Also perform Django test and report coverage and generate html
    package-src         Package source code
    build-base-image    Build base docker images, see details in docker folder
    start-local         Run Docker service stack locally for debug, django is accessible at port 9528
    clean               Clean associated code
        
    Options:
    -h|help       Display this message
    -v|version    Display script version
    -d|directory DIR
                  Indicate django source directory
    "

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

DIR={{cookiecutter.project_name}}

while getopts ":hv" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    d|directory ) DIR=$OPTARG ;;

    * )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done

if [[ "$1" == "" ]]; then
    echo "Missing position parameter: COMMAND" 
    usage
    exit 1
fi

case $1 in
    install-pip )
        pip install -r requirements.txt
        exit 0  ;;
    install-pip-dev )
        pip install -r requirements/develop.txt
        exit 0  ;;
    install-pip-rep )
        pip install -r requirements/report.txt
        exit 0  ;;
    install-dj )
        pip install -r requirements.txt
        python $DIR/manage.py makemigrations
        python $DIR/manage.py migrate
        python $DIR/manage.py collectstatic -l --noinput
        exit 0  ;;
    test-coverage )
        cd $DIR
        coverage run manage.py test
        coverage report -m
        exit 0  ;;
    test-coverage-quick )
        cd $DIR
        coverage run manage.py test --settings=$DIR.settings.quick_test
        coverage report -m
        exit 0  ;;
    test-coverage-html )
        cd $DIR
        rm -rf htmlcov
        coverage run manage.py test
        coverage html -d htmlcov
        exit 0  ;;
    package-src )
        rm -f /tmp/$DIR.tar.gz $DIR.tar.gz
		tar -czf /tmp/$DIR.tar.gz --exclude-from=.gitignore --exclude=.git* .
        mv /tmp/$DIR.tar.gz .
        exit 0  ;;
    build-base-image )
        cd docker
        for i in $(ls); do cd $i && make && cd ../; done
        cd ..
        docker run -v $(pwd):/sources/ --name py_{{cookiecutter.project_name}}_quick_test_c -w /sources py_{{cookiecutter.project_name}}_prod make install-pip-dev
        docker commit -m "pre-install python package for test speedup" py_{{cookiecutter.project_name}}_quick_test_c py_{{cookiecutter.project_name}}_quick_test
        echo "Removing built container..."
        docker rm -v py_{{cookiecutter.project_name}}_quick_test_c
        exit 0  ;;
    start-local )
        docker-compose -f local.yml up -d uwsgi
        echo "Please run django command with \"docker-compose -f local.yml exec uwsgi python {{cookiecutter.project_name}}/manage.py [COMMANDS]\""
        exit 0 ;;
    clean )
        python $DIR/manage.py clean_pyc
        exit 0  ;;
    * ) echo "Invalid command: $1\nPlease use --help/-h to review usage."
        exit 1 ;;
esac
