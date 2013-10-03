#!/usr/bin/env bash

error() {
    echo -e "\e[31m$@\e[0m" 1>&2
}

info() {
    echo -e "\e[32m$@\e[0m" 1>&2
}

if [ $UID -eq 0 ]; then
    error 'Why are you run as root?'
fi

cd `dirname $0`

for file in $(find . -maxdepth 1 -name '*rc' -type f); do
    info copying $file to $HOME
    cp -a $file $HOME
done

# Append my pub-key
if [ -f id_rsa.pub ]; then
    mkdir -p ~/.ssh
    pub_key=`cat id_rsa.pub`
    key_path=~/.ssh/authorized_keys
    if [ -f $key_path ] && grep -q "$pub_key" $key_path; then
        info You\'re already the boss
    else
        info Appending public key
        echo $pub_key >>$key_path
    fi
fi

if [ -d ~/.oh-my-zsh ]; then
    info oh-my-zsh already exists
else
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

if [ ${SHELL:(-3)} != zsh ]; then
    info Changing poly\'s shell to zsh
    chsh -s /bin/zsh poly
fi

if [ -d ~/.vim/bundle/vundle ]; then
    info vundle already exists
else
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

