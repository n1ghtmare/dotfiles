#!/bin/bash

printf 'Setting up dev tool configs:\n'
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


# zsh
# -------------------------------
printf "\n=> Setting up zsh\n"
printf "\n=> Cloning zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/Dev-Config/zsh-plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/Dev-Config/zsh-plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/Dev-Config/zsh-plugins/zsh-history-substring-search
git clone https://github.com/rupa/z $HOME/Dev-Config/zsh-plugins/z
printf "\n =>Creating zsh history file\n"
mkdir -p $HOME/.cache/zsh && touch $HOME/.cache/zsh/history
printf "Done!\n"
rm -rf $HOME/.zshrc
printf "=> Creating zsh config symlink\n"
ln -sv $dotfiles_path/zsh/.zshrc $HOME/.zshrc


# starship prompt
# -------------------------------
printf '\n=> Setting up starship prompt\n'
rm -f $HOME/.config/starship.toml
printf '=> Creating a starship prompt config symlink\n'
ln -sv $dotfiles_path/starship/starship.toml $HOME/.config


# kitty
# -------------------------------
printf '\n=> Setting up kitty\n'

# To check for macos
# if [["$OSTYPE" == "darwin"*]]; then ... else ... fi

kitty_path=$HOME/.config/kitty

if [[ -d $kitty_path ]]; then
    printf '=> An existing kitty config folder exists - will delete it...\n'
    rm -rf $kitty_path
fi

printf '=> Creating kitty config folder symlink\n'
if [[ "$OSTYPE" == "darwin"* ]]; then
    printf '=> Detected macOS (will use the macos kitty config)\n'
    ln -sv $dotfiles_path/kitty/macos $kitty_path
else
    printf '=> Assuming Arch Linux (will use default kitty config)\n'
    ln -sv $dotfiles_path/kitty/arch $kitty_path
fi

# jj
# -------------------------------
printf "\n=> Setting up jj\n"
jj_path=$HOME/.config/jj

if [[ -d $jj_path ]]; then
    printf "=> An existing jj config folder exists - will delete it...\n"
    rm -rf $jj_path
fi

printf "=> Creating jj config folder symlink\n"
ln -sv $dotfiles_path/jj $jj_path

# git
# -------------------------------
printf "\n=> Setting up git\n"
rm -f $HOME/.gitconfig
printf "=> Creating git config symlink\n"
ln -sv $dotfiles_path/git/.gitconfig $HOME/.gitconfig

