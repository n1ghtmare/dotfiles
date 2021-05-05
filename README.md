Create a `Dev-Config` folder in `~`:
```
$ cd ~
$ mkdir Dev-Config
```

# Tmux Setup
Create a symlink for `.tmux.config` as follows:

```
$ ln -sv ~/Dev-Config/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

Install the [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm).
Clone TPM:

```
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Reload the Tmux enviroment (if Tmux is already running) so TMP is sourced:

```
$ tmux source ~/.tmux.conf
```

# Neovim Setup
Create a symlink for `init.vim` as follows:

```
$ ln -sv ~/Dev-Config/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
```

Install [Vim-Plug](https://github.com/junegunn/vim-plug):

Start `nvim` and run `:PlugInstall` then restart nvim and it should be working.

# CoC Setup
You need `nodejs` and `npm` in order to load CoC.


#Window Manager (bspwm) Setup
Run `window-manager-setup.sh`, which will manage all the configs required:

```
$ ./window-manager-setup.sh
```
