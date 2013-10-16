#!/bin/zsh

cd ~/dotfiles/files/
cd ~/.dotfiles/files/

for file in `ls -a`
do
    ln -s $HOME/.dotfiles/files/$file $HOME/$file
done
mv ~/dotfiles ~/.dotfiles
