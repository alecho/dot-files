# /etc/profile run the `path_helper` utility and it causes
# `/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin` to be prepended
# to PATH.
if [ -n "$TMUX" ]; then
  if [ -f /etc/profile ]; then
      PATH=""
      source /etc/profile
  fi
fi

## Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

### Completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Specify an editor
export EDITOR='nvim'
alias vim='nvim'

# Notes
export NOTES_DIR=$HOME/Documents/Notes/

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# GPG tty
export GPG_TTY=$(tty)

# bat
export BAT_THEME=Dracula
alias cat="bat"

# Erlang Flags
export ERL_AFLAGS="-kernel shell_history enabled"

## When installing an erlang version, compile docs for
## reference within IEx.
export KERL_BUILD_DOCS=yes

## But don't build html docs or man pages to save space
export KERL_INSTALL_HTMLDOCS=no
export KERL_INSTALL_MANPAGES=no
export KERL_CONFIGURE_OPTIONS="--disable-debug \
                               --enable-wx \
                               --with-wx-config=/usr/local/bin/wx-config \
                               --without-javac \
                               --without-jinterface"

# Python fix for maxOS 11
export ASDF_PYTHON_PATCH_URL="https://github.com/python/cpython/commit/8ea6353.patch?full_index=1"

# FZF
# <C-t> runs $FZF_CTRL_T_COMMAND
# vim ``<tab> runs _fzf_compgen_path()
# cd ``<tab> runs _fzf_compgen_dir()
# Default command to use when input is tty
export FZF_DEFAULT_COMMAND="ag -gi --hidden --silent"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--keep-right --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --theme=Dracula {}"'

export FZF_COMPLETION_TRIGGER='``'
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Fuzzy-find git log --oneline
function gii() {
  git lol | fzf --reverse --no-sort | awk '{print $1}' | xargs git "$1"
}

# git commit fixup with a fzf list
function gfu() {
  git lol | fzf --reverse --no-sort | awk '{print $1}' | xargs git commit --fixup
}

function gsh() {
  git lol | fzf --reverse --no-sort | awk '{print $1}' | xargs git
}

asdfi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf --tac --no-sort --multi)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do; asdf install $lang $version; done;
    fi
  fi
}

fixup() {
  local selected=$(git lol | fzf --reverse --no-sort | awk '{print $1}')
  git fixup $selected
}

function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="alecho"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# This is updated in a launchd script frequently. This makes prompts less annoying
export UPDATE_ZSH_DAYS=60

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Comment the following line to enable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker gitfast macos tmux bundler ruby rails)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export LSCOLORS="excxbxdxBxEgEdxbxgxcxd"

# Aliases

## General
alias lcat='lolcat'
alias vim='nvim'
alias c='clear'
alias code='cd ~/Code'
alias dot='cd ~/dot-files'
alias des='cd ~/Desktop'

## Tools
### Sum the value of the number on each line.
### `$ ag -c --no-filename some_string `
alias sm="awk 'NF{sum+=\$1} END {print sum}'"

### But first, save some original ls commands as backup under the `o` prefix.
alias ols='ls'
alias oll='ls -Algosh'

alias l='lsd -A'
alias ll='lsd -Al'
alias lll='lsd -Al'
alias ld='lsd -Ad'
alias lf='lsd -Af'
alias lt='lsd -A --tree --depth=1'
alias llt='lsd -A --tree --depth=2'
alias lllt='lsd -A --tree --depth=3'
alias llllt='lsd -A --tree --depth=4'
alias lllllt='lsd -A --tree --depth=5'
alias llllllt='lsd -A --tree --depth=6'
alias lllllllt='lsd -A --tree --depth=7'
alias llllllllt='lsd -A --tree --depth=8'

## Edit rc files
alias vime='vim .envrc'
alias vimt='vim ~/.tmux.conf'
alias vimv='vim ~/.config/nvim/'
alias vimz='vim ~/.zshrc'
alias vimg='vim ~/.gitconfig'
alias reload='source ~/.zshrc'

alias notes=''

## Git
alias gits='git status -sb'

## Control + vim movement to simulate arrow key funtion
bindkey '^h' vi-backward-char
bindkey '^k' up-line-or-beginning-search
bindkey '^l' vi-forward-char
bindkey '^j' down-line-or-beginning-search
bindkey '^r' history-incremental-search-backward

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby Gem
alias gin="cat ~/.default-gems | xargs gem install"
alias gup=gin
alias gun="gem uninstall"
alias gli="gem list"

## Terraform
alias tfp='terraform plan -out=current.plan'
alias tfa='terraform apply -input=true current.plan'

## Tmuxinator
alias tx='tmuxinator'
alias txs='tmuxinator start'
alias txo='tmuxinator open'
alias txe='tmuxinator open'
alias txn='tmuxinator new'
alias txl='tmuxinator list'

export TMUXINATOR_CONFIG="$HOME/dot-files/tmuxinator/"

## asdf-vm
. $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh

## 1Password
eval $(op completion zsh)

# Chromedriver
# Run the following to remove the quarantine on chromedriver.
# xattr -d com.apple.quarantine /usr/local/bin/chromedriver

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $HOME/.asdf/installs/terraform/0.12.29/bin/terraform terraform

eval "$(direnv hook zsh)"

_fzf_complete_mix() {
  _fzf_complete --reverse --prompt="mix> " -- "$@" < <(
  command mix help
  )
}

_fzf_complete_mix_post() {
  awk '{print $2}'
}

# iTerm2 shell integration
if [ -f ~/.iterm2_shell_integration.zsh ]; then
  source ~/.iterm2_shell_integration.zsh
fi

# Machine specific zshrc sourced here.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

# Ensure a few things are running.
tmux start
clear

# Check if the shell configuration file is sourced for the first time, not in
# a tmux session, or the shell is interactive
if [[ -z "$TMUX" ]] || [[ -z "$SOURCED_ONCE" ]] || [[ $- == *i* ]]; then
  # Show start screen
  neofetch
fi

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Mark this script as sourced
export SOURCED_ONCE=true
eval "$(starship init zsh)"
