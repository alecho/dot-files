# /etc/profile run the `path_helper` utility and it causes
# `/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin` to be prepended
# to PATH.
if [ -n "$TMUX" ]; then
  if [ -f /etc/profile ]; then
      PATH=""
      source /etc/profile
  fi
fi
# Specify an editor
export EDITOR='nvim'
alias vim='nvim'


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

# MySQL password
export DATABASE_PASSWORD=root

# GPG tty
export GPG_TTY=$(tty)

# Erlang Flags
export ERL_AFLAGS="-kernel shell_history enabled"
# When installing an erlang version, compile docs for
# reference within IEx.
export KERL_BUILD_DOCS=yes
# But don't build html docs or man pages to save space
export KERL_INSTALL_HTMLDOCS=no
export KERL_INSTALL_MANPAGES=no

# Python fix for maxOS 11
export ASDF_PYTHON_PATCH_URL="https://github.com/python/cpython/commit/8ea6353.patch?full_index=1"


# FZF Colors
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'


# extend fpath to poain to pgen complation script
fpath=(~/.zsh/ $(brew --prefix)/share/zsh/site-functions $fpath)

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
# DISABLE_LS_COLORS="true"

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
plugins=(git gitfast osx mix tmux tmuxinator yarn asdf ruby rails)

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
alias nap='pmset sleepnow'
alias ssaver='open -a ScreenSaverEngine'
alias lcat='lolcat'

## Pretty print things thanks to colorls gem.

### But first, save some original ls commands as backup under the `o` prefix.
alias ols='ls'
alias oll='ls -Algosh'

alias ll='colorls -Alog --sd --dark --gs'
alias lll='colorls -Al --sd --dark --gs'
alias ld='colorls -Ad --dark'
alias lf='colorls -Af --dark'
alias lt='colorls -A --dark --tree'

## Edit rc files
alias vimt='vim ~/.tmux.conf'
alias vimv='vim ~/.vimrc'
alias vimz='vim ~/.zshrc'
alias reload='source ~/.zshrc'

alias notes='nb shell'

# git related commands
alias gits='git status -sb'

bindkey '^h' vi-backward-char
bindkey '^k' up-line-or-beginning-search
bindkey '^l' vi-forward-char
bindkey '^j' down-line-or-beginning-search
bindkey '^r' history-incremental-search-backward

# Go
# export PATH=$PATH:/usr/local/opt/go/libexec/bin
# export GOPATH=$HOME/go
# export GOROOT=/usr/local/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# MySQL
export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# asdf-vm
# Completion and inclution handled by omz asdf plugin above

# Terraform
alias tfp='terraform plan -out=current.plan'
alias tfa='terraform apply -input=true current.plan'

# Tmuxinator
alias t='tmuxinator'
export TMUXINATOR_CONFIG="$HOME/dot-files/tmuxinator/"

# Homebrew in general
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# Chromedriver
# Run the following to remove the quarantine on chromedriver.
# xattr -d com.apple.quarantine /usr/local/bin/chromedriver

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $HOME/.asdf/installs/terraform/0.12.29/bin/terraform terraform
eval "$(direnv hook zsh)"

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
gpg-agent
clear

# Show Apple logo and info
if [[ -n $SKIP_NEOFETCH ]]; then
else
  neofetch
  export SKIP_NEOFETCH=true
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
