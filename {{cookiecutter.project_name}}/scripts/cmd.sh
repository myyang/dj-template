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
    install-pip             Install production python dependancy
    install-pip-dev         Install development python dependancy
    install-pip-rep         Install report
    install-dj              Perform Django commands
    test                    Perform Django test commands 
    test-quick              Perform Django test with memory db and cache
    test-coverage           Perform Django test commands and report test coverage
    test-coverage-quick     Perform Django test commands and report test coverage with memory db and cache
    test-coverage-html      Also perform Django test and report coverage and generate html
    package-prod-src        Package source code for production
    package-staging-src     Package source code for staging
    build-base-image        Build base docker images, see details in docker folder
    start-local             Run Docker service stack locally for debug, django is accessible at port 9528
    start-staging           Run Docker service stack with production settings and formal stack
    stop-and-clean-staging  Stop service stack and clean it
    clean                   Clean associated code
        
    Options:
    -h|help       Display this message
    -v|version    Display script version
    -d|directory DIR
                  Indicate django source directory, for some commands
    -f|forece     Force operations, for some commands
    "

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

DIR={{cookiecutter.project_name}}

while getopts ":hvf" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    d|directory ) DIR=$OPTARG ;;

    f|force     ) FORCE=1 ;;

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
        exit $?  ;;
    install-pip-dev )
        pip install -r requirements/develop.txt
        exit $?  ;;
    install-pip-rep )
        pip install -r requirements/report.txt
        exit $?  ;;
    install-dj )
        pip install -r requirements.txt && \
        python $DIR/manage.py migrate && \
        python $DIR/manage.py collectstatic  --noinput
        exit $? ;;
    test )
        cd $DIR && \
        coverage run manage.py test
        exit $? ;;
    test-quick )
        cd $DIR && \
        coverage run manage.py test --settings=$DIR.settings.quick_test
        exit $? ;;
    test-coverage )
        cd $DIR && \
        coverage run manage.py test && \
        coverage report -m
        exit $?  ;;
    test-coverage-quick )
        cd $DIR && \
        coverage run manage.py test --settings=$DIR.settings.quick_test && \
        coverage report -m
        exit $?  ;;
    test-coverage-html )
        cd $DIR && \
        rm -rf htmlcov && \
        coverage run manage.py test && \
        coverage html -d htmlcov
        exit $?  ;;
    package-prod-src )
        rm -f /tmp/$DIR.tar.gz $DIR.tar.gz && \
        tar -czf /tmp/$DIR.tar.gz --exclude-from=.gitignore --exclude-from=.src-ignore-prod . && \
        mv /tmp/$DIR.tar.gz .
        exit $?  ;;
    package-staging-src )
        rm -f /tmp/$DIR.tar.gz $DIR.tar.gz && \
        tar -czf /tmp/$DIR.tar.gz --exclude-from=.gitignore --exclude-from=.src-ignore-staging . && \
        mv /tmp/$DIR.tar.gz .
        exit $?  ;;
    build-base-image )
        cd docker/prod_base && make && cd ../../
        exit $?  ;;
    build-ci-image )
        BUILD=$(docker images | grep py_{{cookiecutter.project_name}}_quick_test)
        if [[ "$FORCE" == "1" ]]; then BUILD=1; fi
        if [[ "$BUILD" ]]; then
            cd docker/dev_base && make && cd ../../
            docker run -v $(pwd):/sources/ --name py_{{cookiecutter.project_name}}_quick_test_c -w /sources py_{{cookiecutter.project_name}}_dev make install-pip-dev && \
            docker commit -m "pre-install python package for test speedup" py_{{cookiecutter.project_name}}_quick_test_c py_{{cookiecutter.project_name}}_quick_test && \
            echo "Removing built container..."
            docker rm -v py_{{cookiecutter.project_name}}_quick_test_c
        fi
        exit $? ;;
    start-local )
        docker-compose -f compose-local.yml up -d uwsgi && \
        echo "Please run django command with \"docker-compose -f local.yml exec uwsgi python {{cookiecutter.project_name}}/manage.py [COMMANDS]\""
        exit $? ;;
    start-staging )
        docker-compose -f compose-staging.yml up -d && \
        echo "Please run django command with \"docker-compose -f compose-staging.yml exec uwsgi python {{cookiecutter.project_name}}/manage.py [COMMANDS]\""
        exit $? ;;
    stop-and-clean-staging )
        docker-compose -f compose-staging.yml stop && \
        docker-compose -f compose-staging.yml rm -v -f && \
        make clean
        exit $? ;;
    clean )
        find . \( -name *.pyc -o -name __pycache__ -o -name .coverage -o -name *,cover \) -delete
        exit $?  ;;
    * ) echo "Invalid command: $1\nPlease use --help/-h to review usage."
        exit 1 ;;
esac
