#!/usr/bin/env bash
set -o nounset
# http://www.alittlemadness.com/2006/05/24/bash-tip-exit-on-error/
# fail fast
set -o errexit

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
git-core
zsh
python-pip
tmux
vim
python-dev
libevent-dev
autojump
ctags
htop
curl
)
brew_pkgs=(
git
tmux
autojump
htop
wget
macvim
caskroom/cask/brew-cask
)
python_pkgs=(
virtualenv
virtualenvwrapper
)

if [ $UID -ne 0 ]; then
    error 'Superuser privileges are required to run this script.'
    exit 1
fi

cd `dirname $0`

case $(uname -s) in
    "Darwin")
        which brew &>/dev/null || \
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        easy_install pip >/dev/null
        for pkg in ${brew_pkgs[@]}; do
            sudo -u poly brew install $pkg  #TODO
        done

        if [[ "$ITERM_PROFILE" == "" ]]; then
            brew cask install iterm2
        fi
        ;;
    "Linux")
        for pkg in ${apt_pkgs[@]}; do
            apt_install $pkg
        done
        ;;
    *)
        echo "Unsupported OS" $(uname)
        exit 1
        ;;
esac

# python stuff
for pkg in ${python_pkgs[@]}; do
    pip_install $pkg
done

if ! which git-open &>/dev/null; then
    curl -o /usr/bin/git-open https://raw.githubusercontent.com/paulirish/git-open/master/git-open
    chmod +x /usr/bin/git-open
fi
