# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "/home/ddimitrov/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"

# Starship prompt
eval "$(starship init zsh)"


# zsh scripts from github
# source ~/Dev-Config/zsh-plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/Dev-Config/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/Dev-Config/zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/Dev-Config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


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
alias ll="exa -lhg --git --group-directories-first"
alias ..="cd .."

# make nvm work (source)
source /usr/share/nvm/init-nvm.sh

# run `nvm use` if the dir has a .nvmrc (more info here: https://github.com/nvm-sh/nvm#zsh)
source ~/Dev-Config/zsh-plugins/zsh-nvm-use/zsh-use-nvm.zsh
