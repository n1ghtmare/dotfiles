#!/bin/bash

printf 'Setting up dev tool (nvim,tmux) configs:\n'
printf 'This script will delete existing config folders and create symlinks with the ones in this repo!\n'

read -r -p "Are you sure you want to contine? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then exit 0; fi

dotfiles_path=$HOME/Dev-Config/dotfiles


# nvim
# -------------------------------
printf "\n=> Setting up nvim\n"
nvim_path=$HOME/.config/nvim

if [[ -d $nvim_path ]]; then
    printf "=> An existing nvim config folder exists - will delete it...\n"
    rm -rf $nvim_path
fi

printf "=> Creating nvim config folder symlink\n"
ln -sv $dotfiles_path/nvim $nvim_path


# tmux
# -------------------------------
printf "\n=> Setting up tmux\n"
rm -rf $HOME/.tmux.conf
printf "=> Creating tmux config symlink\n"
ln -sv $dotfiles_path/tmux/.tmux.conf $HOME/.tmux.conf

