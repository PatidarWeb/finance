#!/usr/bin/env bash
set -e # This setting is telling the script to exit on a command error.
if [[ "$1" == "-v" ]]; then
    set -x # You refer to a noisy script.(Used to debugging)
fi

GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'

PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd $PWD

export DEBIAN_FRONTEND=noninteractive
export CURRENT_DATE=$(date "+%Y%m%d%H%M%S")

echo "$GREEN Script started at $CURRENT_DATE $NC"

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

# """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
#  Maintainer :- Vallabh Kansagara<vrkansagara@gmail.com> — @vrkansagara
#  Note		  :-
# """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

composer() {

    if [ ! -f "$(pwd)/composer.phar" ]; then
        EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

        if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
            echo >&2 'ERROR: Invalid installer checksum'
            rm composer-setup.php
            exit 1
        fi
        php composer-setup.php --quiet
        RESULT=$?
        rm composer-setup.php
    fi
}

theme() {
    # Run static theme
    if sudo lsof -t -i:3000; then sudo kill -9 $(sudo lsof -t -i:3000); fi
    php -S 0.0.0.0:3000 -d public/theme/index.html -t public/theme
}

git_config() {
    git config core.filemode false
    git config commit.gpgsign true
    git config user.email vrkansagara@gmail.com
    git config user.name "Vallabh Kansagara"
    git config user.signingkey 8BA6E7ABD8112B3E
#    git rebase --signoff HEAD~10
}

main() {
    # Set git config
    git_config

    # Set local
    ${SUDO} localedef -i en_GB -f UTF-8 en_GB.UTF-8
    ${SUDO} localedef -i en_US -f UTF-8 en_US.UTF-8

    if [[ "$1" == "--composer" ]]; then
        composer
        php composer.phar update
        php composer.phar dumpautoload -o
    fi

    if [[ "$1" == "--theme" ]]; then
        theme
    fi

    php composer.phar run permission
    php composer.phar run test

    echo "$0 is complete......[Done.]"
}
main "$@"

# sqlite3 database.sqlite "create table test(id int); drop table test;"
