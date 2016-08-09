#!/usr/bin/env bash
# set -o nounset
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

command_exists() {
	command -v "$@" > /dev/null 2>&1
}

apt_install() {
    if dpkg -l "$1" &>/dev/null; then
        info "$1 already exists"
    else
        info "Installing $1"
        sudo apt-get install "$1" -y
        is_success "$1"
    fi
}

yum_install() {
    if yum -q list installed "$1" &>/dev/null; then
        info "$1 already exists"
    else
        info "Installing $1"
        sudo yum install "$1" -y
        is_success "$1"
    fi
}

pip_install() {
    info "Installing $1"
    # sudo pip install "$1"  -i http://pypi.douban.com/simple/
    sudo -H pip install "$1"
    is_success "$1"
}

apt_pkgs=(
git-core
zsh
tmux
vim
python-dev
libevent-dev
autojump
autojump-zsh
ctags
htop
curl
)
yum_pkgs=(
epel-release
git
zsh
tmux
vim
python-devel
libevent-devel
autojump
autojump-zsh
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

# if [ $UID -ne 0 ]; then
#     error 'Superuser privileges are required to run this script.'
#     exit 1
# fi

cd `dirname $0`

case $(uname -s) in
    "Darwin")
        which brew &>/dev/null || \
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        which pip &>/dev/null || \
            sudo easy_install pip >/dev/null
        for pkg in ${brew_pkgs[@]}; do
            brew install $pkg  #TODO
        done

        if [[ "$ITERM_PROFILE" == "" ]]; then
            brew cask install iterm2
        fi
        ;;
    "Linux")
	if command_exists lsb_release && [ "$(lsb_release -si)"="Ubuntu" ]; then
            for pkg in ${apt_pkgs[@]}; do
                apt_install $pkg
            done
    	elif [ -r /etc/centos-release ] || [ -r /etc/redhat-release ]; then
            for pkg in ${yum_pkgs[@]}; do
                yum_install $pkg
            done
	else
	    echo "Unsupported Linux distro" $(uname)
	    exit 1
	fi
        ;;
    *)
        echo "Unsupported OS" $(uname)
        exit 1
        ;;
esac

# python stuff
if ! command_exists pip; then
    curl "https://bootstrap.pypa.io/get-pip.py"  | sudo python
fi
for pkg in ${python_pkgs[@]}; do
    pip_install $pkg
done

if ! command_exists git-open; then
    sudo curl -o /usr/bin/git-open https://raw.githubusercontent.com/paulirish/git-open/master/git-open
    sudo chmod +x /usr/bin/git-open
fi
