# Windows-bashrc
Set custom commands in .bashrc

## Create .bashrc in Windows
### Method 1 :
1. Clone this repository
   ```bash
   git clone https://github.com/lordmahyar/Windeows-bashrc.git
   ```
2. Copy `.bashrc` to user directory C:\\Users\\`USERNAME`
3. Run Git Bash to apply changes


### Method 2 :
1. Open Git Bash
2. Go to user directory C:\\Users\\`USERNAME`
   ```bash
   cd C:Users/USERNAME
   ```
3. Create `.bashrc` file
   ```bash
   touch .bashrc
   ```
4. Open `.bashrc` with an editor
   ```bash
   start .bashrc
   ```
5. Copy Commands below or add yours
   ```bash
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
   ```
6. Run Git Bash again to apply changes

## Notes
### Set alias commands :
```bash
alias COMMAND_NAME="COMMAND"

# Example
alias dj-run="python manage.py runserver"
```
This means when you run `dj-run` it will run `python manage.py runserver`, so you don't need to type many words and arguments.

### Set functional commands :
```bash
FUNCTION_NAME(){
    COMMAND
}

# Example
dj-run(){
    python manage.py runserver
}

# Example with an argument
dj-pip(){
    python -m pip install "$1"
}
```
This means when you run `dj-pip django` it will run `python -m pip install django`, so you don't need to type many words and arguments.