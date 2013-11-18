#!/usr/bin/env bash

error() {
    echo -e ${@: 1:${#@}-1} "\e[31m${@: -1:1}\e[0m" 1>&2
}

info() {
    echo -e ${@: 1:${#@}-1} "\e[32m${@: -1:1}\e[0m" 1>&2
}

is_success() {
    if [ "$?" -gt 0 ]; then
        error "Something is wrong while installing $1"
        exit 1
    fi
}

apt_install() {
    if dpkg -l "$1" &>/dev/null; then
        info "$1 already exists"
    else
        info "Installing $1"
        apt-get install "$1" -y
        is_success "$1"
    fi
}

pip_install() {
    info "Installing $1"
    pip install "$1"
    is_success "$1"
}

apt_pkgs=(
git
zsh
python-pip
openssh-server
tmux
gitk
python-vte
vim
vim-gtk
python-dev
libevent-dev
autojump
fcitx
fcitx-table-wbpy
ctags
libreoffice
)
python_pkgs=(
virtualenv
virtualenvwrapper
gevent
dnslib
)

if [ $UID -ne 0 ]; then
    error 'Superuser privileges are required to run this script.'
    exit 1
fi

cd `dirname $0`

for pkg in ${apt_pkgs[@]}; do
    apt_install $pkg
done

for pkg in ${python_pkgs[@]}; do
    pip_install $pkg
done

