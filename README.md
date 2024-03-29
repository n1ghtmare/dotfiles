Dotfiles for my Arch setup (running BSPWM) and my dev environment.

If you want to use the setup scripts you need to create a `Dev-Config` folder in `~` and clone this repository in it (so you'll end up with `~/Dev-Config/dotfiles`):

# Dev Environment

### Prerequisites

If you want Tmux, install:

- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).

### Setup

For the dev environment (if you're on macOS, Linux or WSL), run the `dev-environment-setup.sh` (make sure you run `chmod +x` on it first):

```
$ ./dev-environment-setup.sh
```

This will setup kitty, starship prompt, tmux, neovim and bat (this might be changing a lot, so it's a good idea to check the script in case I forgot to update the readme).

# Window Manager

### Prerequisites

The window manager script assumes you have all the necessary packages installed using your favorite package manager (pacman, apt whatever). It's best to read the `window-manager-setup.sh` script to get an up-to-date dependency list.

### Setup

For the window manager run `window-manager-setup.sh`:

```
$ ./window-manager-setup.sh
```

### Misc

For touchpad gestures working install `libinput-gestures` (currently in the AUR), *also* and create a config file `/etc/X11/xorg.conf.d/30-touchpad.conf` with the following configuration:

```
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "NaturalScrolling" "true"
    Option "Tapping" "on"
    Option "DisableWhileTyping" "on"
EndSection
```

Here are some screenshots of the setup:

![output](https://user-images.githubusercontent.com/3255810/118803603-3c456a80-b8ac-11eb-978a-3145e7893a8f.png)
