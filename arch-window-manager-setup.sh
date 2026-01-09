#!/bin/bash

set -e

printf 'Setting up window manager configs (for Linux!):\n'
printf 'This script will delete existing config folders and create symlinks with the ones in this repo!\n'

read -r -p "Are you sure you want to contine? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then exit 0; fi

dotfiles_path=$HOME/Dev-Config/dotfiles


# niri (wayland)
# -------------------------------
printf '\n=> Setting up niri (wayland)\n'
niri_path=$HOME/.config/niri
if [[ -d $niri_path ]]; then
    printf '=> An existing niri config folder exists - will delete it...\n'
    rm -rf $niri_path
fi
printf '=> Creating niri config folder symlink...'
ln -sv $dotfiles_path/niri $niri_path
printf 'done\n'


# fuzzel (wayland launcher)
# -------------------------------
printf '\n=> Setting up fuzzel (wayland launcher)\n'
fuzzel_path=$HOME/.config/fuzzel
if [[ -d $fuzzel_path ]]; then
    printf '=> An existing fuzzel config folder exists - will delete it...\n'
    rm -rf $fuzzel_path
fi
printf '=> Creating fuzzel config folder symlink...'
ln -sv $dotfiles_path/fuzzel $fuzzel_path
printf 'done\n'

# TODO: Add settings for Noctalia here
