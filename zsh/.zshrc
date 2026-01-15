# History file + large limits
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

# Ignore duplicate commands in history
setopt histignoredups

# Commands that start with space won't be saved in history
setopt histignorespace

# Enable vi-style keybindings
bindkey -v

# zsh completion config location
zstyle :compinstall filename "/home/ddimitrov/.zshrc"

# Initialize completion system (wich cache file)
autoload -Uz compinit
compinit -d ~/.cache/zsh/zcompdump

# Default editor and browser for CLI tools
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"

# Initialize Starship prompt
eval "$(starship init zsh)"

# Enable smart path handling (dedupe and case-insensitive)
typeset -U path PATH

# Tool roots
export GOPATH="${GOPATH:-$HOME/go}"
export DENO_HOME="$HOME/.deno"
export PYENV_ROOT="$HOME/.pyenv"
export PNPM_HOME="$HOME/.local/share/pnpm"

# Bin dirs
GO_BIN="$GOPATH/bin"
GOBIN="${GOBIN:-$GO_BIN}"   # respects override
DENO_BIN="$DENO_HOME/bin"
PYENV_BIN="$PYENV_ROOT/bin"
PNPM_BIN="$PNPM_HOME"
LOCAL_BIN="$HOME/.local/bin"
OPENCODE_BIN="$HOME/.opencode/bin"

# Prepend bin dirs to PATH
path=(
  $LOCAL_BIN
  $OPENCODE_BIN
  $DENO_BIN
  $PNPM_BIN
  $GOBIN
  $GO_BIN
  $PYENV_BIN
  $path
)

# zsh plugins to load
source ~/Dev-Config/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/Dev-Config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf keybindings (Ctrl-T for files, Ctrl-R for history, etc.)
source /usr/share/fzf/key-bindings.zsh
# fzf tab completion
source /usr/share/fzf/completion.zsh
# Use ripgrep for fzf file searching, excluding node_modules and .git
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{node_modules,.git}"'
# Ctrl-T uses same source
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Disable fzf colors (use terminal defaults)
export FZF_DEFAULT_OPTS="--no-color"
#export FZF_PREVIEW_COMMAND="bat --theme='base16' color=always {}"
# fzf installer script
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Highlight syntax errors in red (needed for some themes that don't do it by
# default)
ZSH_HIGHLIGHT_STYLES[arg0]="fg=red"

# nvm setup
export NVM_DIR="$HOME/.nvm"
# lazy load nvm
nvm() {
  unset -f nvm
  source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm "$@"
}

# auto use .nvmrc on cd (lazy)
autoload -Uz add-zsh-hook

load-nvmrc() {
  if [[ -f .nvmrc ]]; then
    # load nvm only when needed
    if ! command -v nvm >/dev/null; then
      source "$NVM_DIR/nvm.sh"
    fi
    nvm use --silent >/dev/null
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Enable completion for jujutsu version control system
source <(jj util completion zsh)

# Setup carapace for argument completion
# Link: https://carapace-sh.github.io/carapace-bin/carapace-bin.html
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# Initialize pyenv (adds shims to PATH and enables pyenv commands)
eval "$(pyenv init - --no-rehash)"

# For now delta only works with this env variable (it doesn't detect the theme
# from the bat config)
export BAT_THEME="base16"

# make direnv work - automatically load/unload your .envrc variables 
# For reference: https://direnv.net/
# On arch: sudo pacman -S direnv
eval "$(direnv hook zsh)"


# wrapper for z to open neovim directly -> example: n dotfiles
n() {
    if [ -n "$1" ]; then
        z $1
    fi

    $EDITOR
}

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

# Aliases
alias ll="eza -lhg --git --group-directories-first"
alias ..="cd .."
alias grep="grep --color=auto"


# Google Cloud SDK
# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/ddimitrov/.local/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ddimitrov/.local/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/home/ddimitrov/.local/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ddimitrov/.local/google-cloud-sdk/completion.zsh.inc'; fi
