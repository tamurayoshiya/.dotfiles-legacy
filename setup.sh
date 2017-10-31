#!/bin/zsh

git submodule update --init

cd ~/.dotfiles/files/

for file in `ls -a`
do
    if [ ! -e $HOME/$file ]; then
        echo put $file symlink to home directory
        ln -s $HOME/.dotfiles/files/$file $HOME/$file
    fi
done

# tagbar-phpctagsをコピーして実行権限を与える
target=$HOME/.dotfiles/files/.vim/bin/phpctags
if [ ! -e $target ]; then
    cp $HOME/.dotfiles/files/.vim/bundle/tagbar-phpctags/bin/phpctags $target
    chmod +x $target
fi

# vimprocをmake
cd $HOME/.dotfiles/files/.vim/bundle/vimproc/; make
