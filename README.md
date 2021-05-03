Create a `Dev-Config` folder in `~`:
```
$ cd ~
$ mkdir Dev-Config
```

# Tmux Setup
Create a symlink for `.tmux.config` as follows:

```
$ ln -sv ~/Dev-Config/dotfiles/.tmux.conf ~/.tmux.conf
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

Install the [ChallengerDeep](https://github.com/challenger-deep-theme/tmux) theme for Tmux:

```
$ git clone https://github.com/challenger-deep-theme/tmux ~/Dev-Config/tmux-theme
```

Reload Tmux and everything should work just fine.


# Neovim Setup
Create a symlink for `init.vim` as follows:

```
$ ln -sv ~/Dev-Config/dotfiles/init.vim ~/.config/nvim/init.vim
```

Install [Vim-Plug](https://github.com/junegunn/vim-plug):

```
$ curl -fLo ~/.var/app/io.neovim.nvim/data/nvim/site/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Start `nvim` and run `:PlugInstall` then restart nvim and it should be working.

# CoC Setup
Run `:CocInstall coc-tsserver coc-html coc-json coc-css`


#Window Manager (bspwm) Setup
Run `window-manager-setup.sh`, which will manage all the configs required:

```
$ ./window-manager-setup.sh
```
