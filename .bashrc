# Open .bashrc in editor
alias bashrc="start $HOME/.bashrc"

# Help
GreenBg=`tput setaf 16 && tput setab 2`
GreenText=`tput setaf 2`
Reset=`tput sgr0`
alias dj='
echo ${GreenBg}[HELP]:${Reset}
echo ${GreenText}
echo dj-req
echo dj-run
echo dj-mig [APP_NAME]
echo dj-env ENVIROMENT_DIR
echo dj-app APP_NAME
echo dj-pip PACKAGE_NAME
echo ${Reset}'

# Django
dj-env(){
    source "$1"/Scripts/activate
}
dj-app(){
    python manage.py startapp "$1"
}
dj-pip(){
    python -m pip install "$1"
}
dj-mig(){
    if [ -z "$1" ]
      then
        python manage.py makemigrations && python manage.py migrate
      else
        python manage.py makemigrations "$1" && python manage.py migrate "$1"
    fi
}
alias dj-run="python manage.py runserver"
alias dj-req="python -m pip freeze > requirements.txt"
