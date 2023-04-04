#!/bin/bash

printf 'Setting up window manager configs (for macOS!):\n'
printf 'This script will delete existing config folders and create symlinks with the ones in this repo!\n'

read -r -p "Are you sure you want to contine? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then exit 0; fi

dotfiles_path=$HOME/Dev-Config/dotfiles


# yabai
# -------------------------------
printf '\n=> Setting up yabai\n'

yabai_path=$HOME/.config/yabai

if [[ -d $yabai_path ]]; then
    printf '=> An existing yabai config folder exists - will delete it...\n'
    rm -rf $yabai_path
fi

printf '=> Creating yabai config folder symlink\n'
ln -sv $dotfiles_path/yabai $yabai_path

printf '=> Starting up the yabai service\n'
printf '=> You need to enable access when prompted in the macOS system settings\n'
# TODO: Check if the service is already started and instead of starting - do a restart
brew services start yabai


# skhd
# -------------------------------
printf '\n=> Setting up skhd\n'

skhd_path=$HOME/.config/skhd

if [[ -d $skhd_path ]]; then
    printf '=> An existing skhd config folder exists - will delete it...\n'
    rm -rf $skhd_path
fi

printf '=> Creating skhd config folder symlink\n'
ln -sv $dotfiles_path/skhd $skhd_path

printf '=> Starting up the skhd service\n'
printf '=> You need to enable access when prompted in the macOS system settings\n'
# TODO: Check if the service is already started and instead of starting - do a restart
brew services start skhd


