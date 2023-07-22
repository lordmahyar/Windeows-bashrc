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
dj(){
    printf "\n${GreenBg}[List of Commands]${Reset}\n"
    printf "%-35s %s\n" "${SuccessText}dj-admin [USER_NAME]${Reset}" "creates custom superuser or by USER_NAME and DEFAULT_PASSWORD"
    printf "%-35s %s\n" "${SuccessText}dj-app APP_NAME${Reset}" "creates a new app by APP_NAME"
    printf "%-35s %s\n" "${SuccessText}dj-cleaner${Reset}" "recreates database"
    printf "%-35s %s\n" "${SuccessText}dj-env [ENVIROMENT_DIR]${Reset}" "activates current project environment or ENVIROMENT_DIR"
    printf "%-35s %s\n" "${SuccessText}dj-mig [APP_NAME]${Reset}" "makes migrations for project or specific APP_NAME"
    printf "%-35s %s\n" "${SuccessText}dj-mkenv [ENVIROMENT_NAME]${Reset}" "creates environment as env or ENVIROMENT_NAME"
    printf "%-35s %s\n" "${SuccessText}dj-pip [PACKAGE_NAME]${Reset}" "installs python package by PACKAGE_NAME"
    printf "%-35s %s\n" "${SuccessText}dj-project [PROJECT_NAME]${Reset}" "creates a new project as config"
    printf "%-35s %s\n" "${SuccessText}dj-req${Reset}" "updates requirements.txt"
    printf "%-35s %s\n" "${SuccessText}dj-run${Reset}" "runs django project on server"
    printf "%-35s %s\n" "${SuccessText}dj-shell${Reset}" "opens django project shell"
    printf "%-35s %s\n" "${SuccessText}dj-upg PACKAGE_NAME${Reset}" "upgrades python package by PACKAGE_NAME"
    printf "%-35s %s\n" "${SuccessText}dj-user USER_NAME${Reset}" "creates user by USER_NAME and DEFAULT_PASSWORD"
}

# ACTIVE DJANGO ENVIRONMENT
dj-env(){
    echo "${SuccessText}Activating Virtual Environment ...${Reset}"
    if [ -z "$1" ]
    then
        ENV_DIR=$(find ../env_* -maxdepth 0 -type d)
        source ${ENV_DIR}/Scripts/activate
    else
        source "$1"/Scripts/activate
    fi
}

# CREATE DJANGO ENVIRONMENT
dj-mkenv(){
    echo "${SuccessText}Creating Virtual Environment ...${Reset}"
    if [ -z "$1" ]
    then
        python -m venv env && dj-env env
    else
        python -m venv "$1" && dj-env "$1"
    fi
    dj-upg pip
}

# CREATE DJANGO PROJECT
dj-project(){
    if [ -z "$1" ]
    then
        django-admin startproject config
    else
        django-admin startproject config && python mv config/ "$1"/ 
    fi
}

# CREATE DJANGO APP
dj-app(){
    if [ -z "$1" ]
    then
        echo "${WarningText}run command with APP_NAME${Reset}"
    else
        python manage.py startapp "$1"
    fi
}

# INSTALL PYTHON PACKAGE
dj-pip(){
    if [ -z "$1" ]
    then
        python -m pip install -r requirements.txt
    else
        python -m pip install "$1"
    fi
}

# UPGRADE PYTHON PACKAGE
dj-upg(){
    python -m pip install "$1" --upgrade
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
dj-cleaner(){
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
