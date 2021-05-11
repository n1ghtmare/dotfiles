#!/bin/bash

printf 'Setting up window manager configs:\n'
printf 'This script will delete existing config folders and create symlinks with the ones in this repo!\n'

read -r -p "Are you sure you want to contine? [y/N] " response
response=${response,,}    # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then exit 0; fi

dotfiles_path=$HOME/Dev-Config/dotfiles


# bspwm
# -------------------------------
printf '\n=> Setting up bspwm\n'

bspwm_path=$HOME/.config/bspwm

if [[ -d $bspwm_path ]]; then
	printf '=> An existing bspwm config folder exists - will delete it...\n'
	rm -rf $bspwm_path 
fi

printf '=> Creating bspwm config folder symlink\n'
ln -sv $dotfiles_path/bspwm $bspwm_path
printf '=> Setting up permissions (execute) for bspwmrc and autoload.sh\n'
chmod -v +x $bspwm_path/bspwmrc
chmod -v +x $bspwm_path/autoload.sh


# sxhkd
# -------------------------------
printf '\n=> Setting up sxhkd\n'

sxhkd_path=$HOME/.config/sxhkd

if [[ -d $sxhkd_path ]]; then
	printf '=> An existing sxhkd config folder exists - will delete it...\n'
	rm -rf $sxhkd_path 
fi

printf '=> Creating sxhkd config folder symlink\n'
ln -sv $dotfiles_path/sxhkd $sxhkd_path


# picom
# -------------------------------
printf '\n=> Setting up picom\n'

picom_path=$HOME/.config/picom

if [[ -d $picom_path ]]; then
	printf '=> An existing picom config folder exists - will delete it...\n'
	rm -rf $picom_path 
fi

printf '=> Creating picom config folder symlink\n'
ln -sv $dotfiles_path/picom $picom_path


# polybar
# -------------------------------
printf '\n=> Setting up polybar\n'

polybar_path=$HOME/.config/polybar

if [[ -d $polybar_path ]]; then
	printf '=> An existing polybar config folder exists - will delete it...\n'
	rm -rf $polybar_path 
fi

printf '=> Creating polybar config folder symlink\n'
ln -sv $dotfiles_path/polybar $polybar_path 


# rofi
# -------------------------------
printf '\n=> Setting up rofi\n'

rofi_path=$HOME/.config/rofi

if [[ -d $rofi_path ]]; then
	printf '=> An existing rofi config folder exists - will delete it...\n'
	rm -rf $rofi_path 
fi

printf '=> Creating rofi config folder symlink\n'
ln -sv $dotfiles_path/rofi $rofi_path 


# dunst
# -------------------------------
printf '\n=> Setting up dunst\n'

dunst_path=$HOME/.config/dunst

if [[ -d $dunst_path ]]; then
	printf '=> An existing dunst config folder exists - will delete it...\n'
	rm -rf $dunst_path 
fi

printf '=> Creating dunst config folder symlink\n'
ln -sv $dotfiles_path/dunst $dunst_path 
