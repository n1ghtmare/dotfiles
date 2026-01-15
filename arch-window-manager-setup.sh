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


# noctalia (shell)
# -------------------------------
# Only the custom palette is tracked. Everything else (bar layout, dock,
# widgets, ...) is configured per-machine in the Settings UI and lives in the
# untracked ~/.config/noctalia/config.toml -- deliberately not synced.
#
# Note this cannot be a whole-folder symlink: noctalia writes its own files
# (colors.json, plugins.json, plugins/, ...) into the config folder. And it does
# not follow a directory symlink for palettes/, so the .json is linked directly.
printf '\n=> Setting up noctalia (shell)\n'
noctalia_path=$HOME/.config/noctalia

mkdir -p $noctalia_path/palettes
printf '=> Linking noctalia palette...'
ln -sfnv $dotfiles_path/noctalia/palettes/Noirbuddy-Oxide.json $noctalia_path/palettes/Noirbuddy-Oxide.json
printf 'done\n'

printf '=> Activating palette...\n'
noctalia msg color-scheme-set custom Noirbuddy-Oxide || \
    printf '=> noctalia not running yet - activate later with:\n     noctalia msg color-scheme-set custom Noirbuddy-Oxide\n'
