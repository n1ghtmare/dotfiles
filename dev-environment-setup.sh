#!/bin/bash
# Symlinks dev tool configs from this repo into ~/.config and $HOME.
# Existing configs at the target locations are deleted.
#
# Run ./arch-dependencies-setup.sh first on a fresh machine.
# Note: nvm (~/.nvm) and the zsh plugins are cloned here, everything else is a symlink.

set -e

read -r -p "This will delete existing configs and replace them with symlinks into this repo. Continue? [y/N] " response
response=${response,,} # tolower
if [[ ! "$response" =~ ^(yes|y)$ ]]; then exit 0; fi

dotfiles_path=$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")
zsh_plugins_path=$HOME/Dev-Config/zsh-plugins

# Delete whatever is at $2 and symlink $1 there.
link() {
    local src=$1 dest=$2
    if [[ -e $dest || -L $dest ]]; then
        printf '=> Removing existing %s\n' "$dest"
        rm -rf "$dest"
    fi
    ln -sv "$src" "$dest"
}

# Clone a plugin repo unless it already exists (keeps the script idempotent).
clone() {
    local url=$1 dest=$2
    if [[ -d $dest ]]; then
        printf '=> %s already cloned, skipping\n' "$dest"
    else
        git clone "$url" "$dest"
    fi
}

# nvim
# -------------------------------
printf '\n=> Setting up nvim\n'
link "$dotfiles_path/nvim" "$HOME/.config/nvim"

# kitty (arch and macos variants)
# -------------------------------
printf '\n=> Setting up kitty\n'
if [[ "$OSTYPE" == "darwin"* ]]; then
    printf '=> Detected macOS (will use the macos kitty config)\n'
    link "$dotfiles_path/kitty/macos" "$HOME/.config/kitty"
else
    printf '=> Assuming Arch Linux (will use the default kitty config)\n'
    link "$dotfiles_path/kitty/arch" "$HOME/.config/kitty"
fi

# ghostty
# -------------------------------
printf '\n=> Setting up ghostty\n'
link "$dotfiles_path/ghostty" "$HOME/.config/ghostty"

# jj
# -------------------------------
printf '\n=> Setting up jj\n'
link "$dotfiles_path/jj" "$HOME/.config/jj"

# git
# -------------------------------
printf '\n=> Setting up git\n'
link "$dotfiles_path/git/.gitconfig" "$HOME/.gitconfig"

# fontconfig
# -------------------------------
printf '\n=> Setting up fontconfig\n'
link "$dotfiles_path/fontconfig" "$HOME/.config/fontconfig"

# starship
# -------------------------------
printf '\n=> Setting up starship\n'
link "$dotfiles_path/starship/starship.toml" "$HOME/.config/starship.toml"

# ytfzf
# -------------------------------
printf '\n=> Setting up ytfzf\n'
link "$dotfiles_path/ytfzf" "$HOME/.config/ytfzf"

# zsh
# -------------------------------
printf '\n=> Setting up zsh\n'
clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_plugins_path/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_plugins_path/zsh-syntax-highlighting"

mkdir -p "$HOME/.cache/zsh" && touch "$HOME/.cache/zsh/history"
link "$dotfiles_path/zsh/.zshrc" "$HOME/.zshrc"

printf '\nDone!\n'
