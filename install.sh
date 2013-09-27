#!/usr/bin/env bash

cd `dirname $0`
for file in $(find . -maxdepth 1 -name '*rc' -type f); do
    cp -a $file $HOME
done

if ! [ -d ~/.vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
