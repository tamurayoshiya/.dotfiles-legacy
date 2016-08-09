#!/bin/zsh

cd ~/.dotfiles/files/

for file in `ls -a`
do
    if [ ! -e $HOME/$file ]; then
        echo put $file symlink to home directory
        ln -s $HOME/.dotfiles/files/$file $HOME/$file
    fi
done
