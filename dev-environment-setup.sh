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


# tmux
# -------------------------------
printf "\n=> Setting up tmux\n"
rm -rf $HOME/.tmux.conf
printf "=> Creating tmux config symlink\n"
ln -sv $dotfiles_path/tmux/.tmux.conf $HOME/.tmux.conf


# starship prompt
# -------------------------------
printf '\n=> Setting up starship prompt\n'
rm -f $HOME/.config/starship.toml
printf '=> Creating a starship prompt config symlink\n'
ln -sv $dotfiles_path/starship/starship.toml $HOME/.config


# kitty
# -------------------------------
printf '\n=> Setting up kitty\n'

kitty_path=$HOME/.config/kitty

if [[ -d $kitty_path ]]; then
	printf '=> An existing kitty config folder exists - will delete it...\n'
	rm -rf $kitty_path
fi

printf '=> Creating kitty config folder symlink\n'
ln -sv $dotfiles_path/kitty $kitty_path


# bat
# -------------------------------
printf '\n=> Setting up bat\n'

bat_path=$HOME/.config/bat

if [[ -d $bat_path ]]; then
	printf '=> An existing bat config folder exists - will delete it...\n'
	rm -rf $bat_path
fi

printf '=> Creating bat config folder symlink\n'
ln -sv $dotfiles_path/bat $bat_path


# omnisharp
# -------------------------------
printf "\n=> Setting up omnisharp formatting\n"
rm -rf $HOME/.omnisharp/omnisharp.json
printf "=> Creating omnisharp config symlink\n"
ln -sv $dotfiles_path/omnisharp/omnisharp.json $HOME/.omnisharp/omnisharp.json
