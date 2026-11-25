#!/bin/bash
# System dependencies for my Arch setup (niri + noctalia shell + dev tools).
#
# Run the other setup scripts after this one:
#   ./dev-environment-setup.sh      dev tool configs + symlinks
#   ./arch-window-manager-setup.sh  niri + noctalia shell
#
# Not covered here (installed separately):
#   yay -S bemoji carapace-bin noctalia-qs noctalia-shell   # AUR
#   cargo install tiny-dc                                   # zsh `dc`/`z` helpers
#   Berkeley Mono + Liga SFMono Nerd Font                   # proprietary/AUR fonts
#   nvm  ->  git clone https://github.com/nvm-sh/nvm ~/.nvm # lazy-loaded by .zshrc

set -e

packages=(
    # Window manager & session (Wayland)
    niri                   # scrollable-tiling compositor
    xwayland-satellite     # X11 app support for niri
    quickshell             # toolkit noctalia-shell runs on

    # Terminals
    kitty
    ghostty

    # Shell & CLI tools
    zsh
    starship
    fzf
    ripgrep
    fd
    bat
    eza
    direnv
    pyenv

    # Version control
    git
    jujutsu
    github-cli             # `gh` - also git credential helper
    git-lfs
    git-delta              # used for interactive diffs
    difftastic             # `difft` - default diff tool for git and jj
    mergiraf               # structural git merge driver

    # Media / web
    firefox
    ytfzf
    yt-dlp
    mpv

    # Desktop utilities (niri keybindings + noctalia shell)
    thunar                 # Mod+E file manager
    gvfs                   # thunar mounts/trash
    fuzzel                 # picker for the bemoji binding (Super+Alt+S)
    brightnessctl
    cliphist               # clipboard history for noctalia
    wireplumber            # `wpctl` volume keys

    # Fonts
    noto-fonts
    noto-fonts-emoji
    ttf-liberation
    ttf-dejavu
)

printf 'Installing system dependencies for the niri + noctalia setup.\n'
sudo pacman -S --needed "${packages[@]}"
