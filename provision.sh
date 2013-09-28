#!/usr/bin/env bash

error() {
    echo -e "\e[31m$@\e[0m" 1>&2
}

info() {
    echo -e "\e[32m$@\e[0m" 1>&2
}

is_success() {
    if [ "$?" -gt 0 ]; then
        error Something is wrong while installing $1
        exit 1
    fi
}

apt_install() {
    if which "$1" &>/dev/null; then
        info "$1" already exists
    else
        info Installing "$1"
        apt-get install "$1" -y
        is_success "$1"
    fi
}

pip_install() {
    pip install "$1"
    is_success "$1"
}

apt_pkgs=(
git
zsh
python-vte
vim-gtk
python-dev
libevent-dev
autojump
libreoffice
fcitx
fcitx-table-wbpy
python-pip
ctags
)
python_pkgs=(
virtualenv
virtualenvwrapper
)

for pkg in ${apt_pkgs[@]}; do
    apt_install $pkg
done

for pkg in ${python_pkgs[@]}; do
    pip_install $pkg
done

if [ -d ~/.oh-my-zsh ]; then
    info oh-my-zsh already exists
else
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

