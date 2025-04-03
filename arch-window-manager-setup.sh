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


# waybar (wayland)
# -------------------------------
printf '\n=> Setting up waybar (wayland)\n'
waybar_path=$HOME/.config/waybar
if [[ -d $waybar_path ]]; then
    printf '=> An existing waybar config folder exists - will delete it...\n'
    rm -rf $waybar_path
fi
printf '=> Creating waybar config folder symlink...'
ln -sv $dotfiles_path/waybar $waybar_path
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


# bspwm
# -------------------------------
printf '\n=> Setting up bspwm\n'

bspwm_path=$HOME/.config/bspwm

if [[ -d $bspwm_path ]]; then
    printf '=> An existing bspwm config folder exists - will delete it...\n'
    rm -rf $bspwm_path
fi
printf '=> Creating bspwm config folder symlink...'
ln -sv $dotfiles_path/bspwm $bspwm_path
printf 'done\n'
printf '=> Setting up permissions (execute) for bspwmrc and autoload.sh...'
chmod -v +x $bspwm_path/bspwmrc
chmod -v +x $bspwm_path/autoload.sh
printf 'done\n'


# sxhkd
# -------------------------------
printf '\n=> Setting up sxhkd\n'
sxhkd_path=$HOME/.config/sxhkd
if [[ -d $sxhkd_path ]]; then
    printf '=> An existing sxhkd config folder exists - will delete it...\n'
    rm -rf $sxhkd_path
fi
printf '=> Creating sxhkd config folder symlink...'
ln -sv $dotfiles_path/sxhkd $sxhkd_path
printf 'done\n'


# picom
# -------------------------------
printf '\n=> Setting up picom\n'
picom_path=$HOME/.config/picom
if [[ -d $picom_path ]]; then
    printf '=> An existing picom config folder exists - will delete it...\n'
    rm -rf $picom_path
fi
printf '=> Creating picom config folder symlink...'
ln -sv $dotfiles_path/picom $picom_path
printf 'done\n'


# polybar
# -------------------------------
printf '\n=> Setting up polybar\n'
polybar_path=$HOME/.config/polybar
if [[ -d $polybar_path ]]; then
    printf '=> An existing polybar config folder exists - will delete it...\n'
    rm -rf $polybar_path
fi
printf '=> Creating polybar config folder symlink...'
ln -sv $dotfiles_path/polybar $polybar_path
printf 'done\n'


# rofi
# -------------------------------
printf '\n=> Setting up rofi\n'
rofi_path=$HOME/.config/rofi
if [[ -d $rofi_path ]]; then
    printf '=> An existing rofi config folder exists - will delete it...\n'
    rm -rf $rofi_path
fi
printf '=> Creating rofi config folder symlink...'
ln -sv $dotfiles_path/rofi $rofi_path
printf 'done\n'


# ytfzf
# -------------------------------
printf '\n=> Setting up ytfzf\n'
ytfzf_path=$HOME/.config/ytfzf
if [[ -d $ytfzf_path ]]; then
    printf '=> An existing ytfzf config folder exists - will delete it...\n'
    rm -rf $ytfzf_path
fi
printf '=> Creating ytfzf config folder symlink...'
ln -sv $dotfiles_path/ytfzf $ytfzf_path
printf 'done\n'


# dunst
# -------------------------------
printf '\n=> Setting up dunst\n'
dunst_path=$HOME/.config/dunst
if [[ -d $dunst_path ]]; then
    printf '=> An existing dunst config folder exists - will delete it...\n'
    rm -rf $dunst_path
fi
printf '=> Creating dunst config folder symlink...'
ln -sv $dotfiles_path/dunst $dunst_path
printf 'done\n'


# xinit
# -------------------------------
printf '\n=> Setting up xinit (and dependencies)\n'
rm -f $HOME/.Xresources
rm -f $HOME/.xinitrc
printf '=> Creating an Xresources symlink...'
ln -sv $dotfiles_path/xinit/.Xresources $HOME
printf 'done\n'
printf '=> Creating an xinitrc symlink...'
ln -sv $dotfiles_path/xinit/.xinitrc $HOME
printf 'done\n'


# libinput gestures (allow for gestures on touchpad)
# -------------------------------
printf '\n=> Setting up libinput-gestures\n'
rm -f $HOME/.config/libinput-gestures.conf
printf '=> Creating libinput-gestures conf symlink...'
ln -sv $dotfiles_path/libinput-gestures/libinput-gestures.conf $HOME/.config
printf 'done\n'

