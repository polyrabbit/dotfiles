#!/usr/bin/env bash
set -o nounset
# http://www.alittlemadness.com/2006/05/24/bash-tip-exit-on-error/
set -o errexit

error() {
    echo -e ${@: 1:${#@}-1} "\e[31m${@: -1:1}\e[0m" 1>&2
}

info() {
    echo -e ${@: 1:${#@}-1} "\e[32m${@: -1:1}\e[0m" 1>&2
}

if [ $UID -eq 0 ]; then
    error -n "Why are you run as root, continue [y/N]? "
    read c
    if [ "$c" != 'y' -a "$c" != 'Y' -a "$c" != 'yes' -a "$c" != 'YES' ]; then
        error "Aborted"
        exit 1
    fi
    info "Provisioning root"
fi

cd `dirname $0`

configs=(.bashrc .vimrc .zshrc .gitconfig .tmux.conf .p10k.zsh)

for file in ${configs[@]}; do
    if [ -e $file ]; then
        info "copying $file to $HOME"
        cp -a $file $HOME
    fi
done

# Append my pub-key
if [ -f id_rsa.pub ]; then
    mkdir -p ~/.ssh
    pub_key=`cat id_rsa.pub`
    key_path=~/.ssh/authorized_keys
    if [ -f $key_path ] && grep -q "$pub_key" $key_path; then
        info "Key authorized, you're already the boss"
    else
        info "Appending public key"
        echo $pub_key >>$key_path
    fi
fi

if ! which zsh &>/dev/null; then
    sudo apt-get install zsh -y;
fi

if [ -d ~/.oh-my-zsh ]; then
    info "oh-my-zsh already exists"
else
    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O- | sh
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
fi

if [ ${SHELL:(-3)} != zsh ]; then
    info "Changing ${USER}'s shell to zsh"
    chsh -s /bin/zsh
fi

if [ -d ~/.vim/bundle/vundle ]; then
    info "vundle already exists"
else
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

