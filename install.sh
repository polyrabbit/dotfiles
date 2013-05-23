#!/usr/bin/env bash

copy_file() {
    # mkdir -p $2
    if [ -f $2 ]; then
        mv $2 /tmp/`basename $2`.bak
    elif [ -d $2 ]; then
        cd $2
        copy_file $1 `basename $1`
        return
    fi
    cp $1 $2
}
install_path=`readlink -f $0`
dotfiles_root=`dirname $install_path`
for file in `find $dotfiles_root -name *rc`; do
    copy_file ${dotfiles_root}/`basename $file` $HOME
done
if ! [ -d ~/.vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
