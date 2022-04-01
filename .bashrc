# Open .bashrc in editor
alias bashrc="start $HOME/.bashrc"

DEFAULT_PASSWORD="1234"

# Colors
Reset=`tput sgr0`
# Text Colors
ErrorText=`tput setaf 1`
SuccessText=`tput setaf 2`
WarningText=`tput setaf 3`
InfoText=`tput setaf 4`
# Background Colors
GreenBg=`tput setaf 16 && tput setab 2`

# Help
alias dj='
echo ${GreenBg}[HELP]:${Reset}
echo ${SuccessText}
echo dj-req
echo dj-run
echo dj-shell
echo dj-mig [APP_NAME]
echo dj-admin [USER_NAME]
echo dj-user USER_NAME
echo dj-env ENVIROMENT_DIR
echo dj-app APP_NAME
echo dj-clean
echo dj-pip PACKAGE_NAME
echo ${Reset}'

# ACTIVE DJANGO ENVIROMENT
dj-env(){
    source "$1"/Scripts/activate
}

# CREATE DJANGO APP
dj-app(){
    python manage.py startapp "$1"
}

# INSTALL PYTHON PACKAGE
dj-pip(){
    python -m pip install "$1"
}

# DO DJANGO MIGRATION
dj-mig(){
    if [ -z "$1" ]
      then
        python manage.py makemigrations && python manage.py migrate
      else
        python manage.py makemigrations "$1" && python manage.py migrate "$1"
    fi
}

# CREATE SIMPLE USER
dj-user(){
    if [ -z "$1" ]
      then
        echo "${WarningText}run command with USER_NAME${Reset}"
      else
        python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_user('"$1"', '"$1"@mail.com', '${DEFAULT_PASSWORD}')"
    fi
}

# CREATE SUPERUSER
dj-admin(){
    if [ -z "$1" ]
      then
        python manage.py createsuperuser
      else
        python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('"$1"', '"$1"@mail.com', '${DEFAULT_PASSWORD}')"
    fi
}

# CLEAN DATABASE
dj-clean(){
  rm -rf db.sqlite3
  find . -path "*/migrations/*.pyc"  -delete
  find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
  python manage.py makemigrations
  python manage.py migrate
}

# DJANGO SHELL
alias dj-shell="python manage.py shell"

# RUN DJANGO PROJECT
alias dj-run="python manage.py runserver"

# UPDATE REQUIREMENTS
alias dj-req="python -m pip freeze > requirements.txt"
