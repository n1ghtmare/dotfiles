# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
# Ignore duplicate commands in history
setopt histignoredups
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "/home/ddimitrov/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

export EDITOR="nvim"
export VISUAL="nvim"
# export BROWSER="firefox"

# Starship prompt
eval "$(starship init zsh)"

# auto cd into folder paths
# setopt autocd
setopt histignorespace

# make sure tab completion works
autoload -U compinit && compinit

# zsh scripts from github
# source ~/Dev-Config/zsh-plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/Dev-Config/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/Dev-Config/zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/Dev-Config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/Dev-Config/zsh-plugins/z/z.sh

ZSH_HIGHLIGHT_STYLES[arg0]="fg=red"
# fzf keybindings
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{node_modules,.git}"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--no-color"
#export FZF_PREVIEW_COMMAND="bat --theme='base16' color=always {}"

# Aliases
alias htop="gotop"
alias btop="bpytop"
alias ll="eza -lhg --git --group-directories-first"
alias ..="cd .."
alias grep="grep --color=auto"
# alias docker="podman"

# make nvm work
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# run `nvm use` if the dir has a .nvmrc (more info here: https://github.com/nvm-sh/nvm#zsh)
source ~/Dev-Config/zsh-plugins/zsh-nvm-use/zsh-nvm-use.sh

# make gopath work
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# wrapper for z to open neovim directly -> example: n dotfiles
n() {
    if [ -n "$1" ]; then
        z $1
    fi

    $EDITOR
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `pipx` on 2023-06-21 11:45:45
export PATH="$PATH:/home/ddimitrov/.local/bin"

# make pyenv work
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# make asdf work
# For arch: sudo pacman -S asdf-vm
# . /opt/asdf-vm/asdf.sh

# For now delta only works with this env variable (it doesn't detect the theme
# from the bat config)
export BAT_THEME="base16"

# make direnv work - automatically load/unload your .envrc variables 
# For reference: https://direnv.net/
# On arch: sudo pacman -S direnv
eval "$(direnv hook zsh)"


# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/ddimitrov/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ddimitrov/Downloads/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/home/ddimitrov/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ddimitrov/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ddimitrov/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ddimitrov/.local/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ddimitrov/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ddimitrov/.local/google-cloud-sdk/completion.zsh.inc'; fi

# Integrate with tiny-dc so that we can cd into the directory that tiny-dc outputs
dc() {
    local result=$(command tiny-dc "$@")
    [ -n "$result" ] && cd -- "$result"
}

z() {
    local result=$(command tiny-dc z "$@")
    [ -n "$result" ] && cd -- "$result"
}

# on cd run tiny-fe push
cd() {
    builtin cd "$@" && tiny-dc push "$PWD"
}


# alias kubectl="minikube kubectl --"

# pnpm
export PNPM_HOME="/home/ddimitrov/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
