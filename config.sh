#! /bin/bash

DOTFILES=(.gitconfig .gitignore .zshrc)

for dotfile in $(echo ${DOTFILES[*]});
do
    cp ~/dotfiles/$(echo $dotfile) ~/$(echo $dotfile)
done

cp ~/dotfiles/starship.toml ~/.config/starship.toml

cp -r ~/dotfiles/nvim ~/.config/
