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
    info Installing "$1"
    pip install "$1"
    is_success "$1"
}

apt_pkgs=(
git
zsh
python-pip
tmux
python-vte
vim-gtk
python-dev
libevent-dev
autojump
libreoffice
fcitx
fcitx-table-wbpy
ctags
)
python_pkgs=(
virtualenv
virtualenvwrapper
gevent
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

# Append my pub-key
if [ -f id_rsa.pub ]; then
    mkdir -p ~/.ssh
    pub_key=`cat id_rsa.pub`
    if grep -q "$pub_key" ~/.ssh/authorized_keys; then
        info You\'re already the boss
    else
        info Appending public key
        echo $pub_key >>~/.ssh/authorized_keys
    fi
fi

if [ -d ~/.oh-my-zsh ]; then
    info oh-my-zsh already exists
else
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

info Changing poly\'s shell to zsh
chsh -s /bin/zsh poly
