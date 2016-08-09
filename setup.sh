#!/bin/zsh

cd ~/.dotfiles/files/

for file in `ls -a`
do
    if [ ! -e $HOME/$file ]; then
        ln -s $HOME/.dotfiles/files/$file $HOME/$file
    fi
done
