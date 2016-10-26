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
        python $DIR/manage.py collectstatic -l
        exit 0  ;;
    test-coverage )
        coverage run --source=$DIR $DIR/manage.py test
        coverage report -m
        exit 0  ;;
    test-coverage-html )
        rm -rf coverage-html
        coverage run --source=$DIR $DIR/manage.py test
        coverage html -d htmlcov
        exit 0  ;;
    package-src )
        rm -f /tmp/$DIR.tar.gz $DIR.tar.gz
		tar -czf /tmp/$DIR.tar.gz --exclude-from=.gitignore --exclude=.git* .
        mv /tmp/$DIR.tar.gz .
        exit 0  ;;
    clean )
        python $DIR/manage.py clean_pyc
        exit 0  ;;
    * ) echo "Invalid command: $1\nPlease use --help/-h to review usage."
        exit 1 ;;
esac
