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
if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

## Completions
### Enable bash completions in zsh (disabled to avoid conflicts with _arguments)
# autoload -U +X bashcompinit && bashcompinit

### Check if compinit is already loaded, if not, load it (disabled; we init later)
# if ! type "_comps" > /dev/null; then
#   autoload -Uz +X compinit && compinit
# fi

# NOTE: Zsh reads the `fpath` array for autoloaded functions. Keeping this
# FPATH for other tooling is harmless, but we set `fpath` properly after OMZ.
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Specify an editor
export EDITOR='nvim'
alias vim='nvim'

# Notes
export NOTES_DIR=$HOME/Documents/Notes/
export ZK_NOTEBOOK_DIR=$NOTES_DIR/daily/
alias notes='vim $ZK_NOTEBOOK_DIR'

# The actual autocomplete function.
function _zk {
  local state context line
  typeset -A opt_args

  _arguments -C\
    '1: :->level1'\
    '*:: :->extra'\
    && return 0

  case $state in
    level1)
      case $line[1] in
        edit)
          _arguments -C\
            '--force[Do not confirm before editing many notes at the same time.]'\
            '--path[Path of the note/notes to edit]: :_directories'\
            '--tag[Tag filter for the notes]: :_tags'\
            '--interactive[Enable interactive mode]'\
            '*:: :->extra'
          return 0
          ;;
      esac
      _describe 'command' commands && return 0
      ;;

    extra)
      case $line[1] in
        edit)
          _arguments -C\
            '--path[Path of the note/notes to edit]: :_directories'\
            '--tag[Tag filter for the notes]: :_tags'\
            '--interactive[Enable interactive mode]'\
            '*:: :->extra'
          return 0
          ;;
      esac
      _describe 'command' commands && return 0
      ;;
  esac
}

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

# FZF
# <C-t> runs $FZF_CTRL_T_COMMAND
# vim ``<tab> runs _fzf_compgen_path()
# cd ``<tab> runs _fzf_compgen_dir()
# Default command to use when input is tty
export FZF_DEFAULT_COMMAND="ag -gi --hidden --silent"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--keep-right --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --bind=ctrl-j:preview-page-down,ctrl-k:preview-page-up'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --theme=Dracula {}"'

export FZF_COMPLETION_TRIGGER='**'
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

alias f="python select_and_run_command.py"

# Fuzzy-find git log --oneline
function gii() {
  git lol | fzf --reverse --no-sort | awk '{print $1}' | xargs git "$1"
}

function gsh() {
  git lol | fzf --reverse --no-sort | awk '{print $1}' | xargs git
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

function confetti {
  STATUS=$?
  if [ $STATUS -eq 0 ]; then
    open raycast://confetti
  fi
}

# ZSH/OMZ options
export UPDATE_ZSH_DAYS=60
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git docker gitfast macos bundler ruby rails)

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# --------------------
# Zellij completion FIX
# --------------------
# Put Homebrew site-functions first in fpath so `_zellij` wins
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
# Deduplicate while keeping first occurrence
typeset -U fpath
# Initialize completion (after OMZ)
autoload -U compinit
compinit -u
# Register completions for custom tools
compdef _zk zk
# Bind Zellij's completion from Homebrew-installed _zellij
compdef -d zellij 2>/dev/null
compdef _zellij zellij
# DO NOT eval "$(zellij setup --generate-completion zsh)" here; it can
# trigger `_arguments` outside a completion context.

# MySQL mysql2 gem
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/zstd/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include -I/opt/homebrew/opt/zstd/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig:/opt/homebrew/opt/zstd/lib/pkgconfig"

# Language env
export LSCOLORS="excxbxdxBxEgEdxbxgxcxd"

# Aliases
alias lcat='lolcat'
alias vim='nvim'
alias c='clear'
alias code='cd ~/Code'
alias dot='cd ~/dotfiles'
alias des='cd ~/Desktop'

alias pbp='pbpaste'
alias pbc='pbcopy'
# Copy the last command to the clipboard
alias clc="fc -ln -1 | awk '{\$1=\$1}1' ORS='' | pbcopy"

# Tools
alias sm="awk 'NF{sum+=\$1} END {print sum}'"

# Original ls backups
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

# Edit rc files
alias vime='vim .envrc'
alias vimt='vim ~/.tmux.conf'
alias vimv='vim ~/.config/nvim/'
alias vimz='vim ~/.zshrc'
alias vimzl='vim ~/.zshrc.local'
alias vimzellij='vim ~/.config/zellij/config.kdl'
alias vimg='vim ~/.gitconfig'
alias vimgi='vim ~/.gitignore_global'
alias vimm='vim ~/mise.toml'
alias vimml='vim mise.local.toml'
alias vimw='vim ~/scripts/work.rb'
alias vims='vim ~/.config/starship.toml'
alias vimsshc='vim ~/.ssh/config'

alias reload='source ~/.zshrc'

# Git
alias gits='git status -sb'

# Work script
alias work='ruby ~/scripts/work.rb'

# Vim edit mode
bindkey -v

# Control + vim movement to simulate arrow key function
bindkey '^h' vi-backward-char
bindkey '^k' up-line-or-beginning-search
bindkey '^l' vi-forward-char
bindkey '^j' down-line-or-beginning-search
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^b' vi-backward-word
bindkey '^w' vi-forward-word

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby Gem
alias gin="cat ~/.default-gems | xargs gem install"
alias gup=gin
alias gun="gem uninstall"
alias gli="gem list"

## Scripts
PATH=$PATH:$HOME/scripts

## Terraform
alias tfp='terraform plan -out=current.plan'
alias tfa='terraform apply -input=true current.plan'

## Zellij
alias zel='/usr/local/bin/zellij'

## asdf-vm
#. $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh

## Mise-em-place
eval "$(mise activate zsh)"

## 1Password
eval $(op completion zsh)

## Bun.js
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

### Completions
[ -s "/Users/andrewlechowicz/.bun/_bun" ] && source "/Users/andrewlechowicz/.bun/_bun"

# Chromedriver
# xattr -d com.apple.quarantine /usr/local/bin/chromedriver

# Docker CLI
export PATH="$HOME/.docker/bin:$PATH"

# bashcompinit (commented to avoid conflicts with native zsh completion)
# autoload -U +X bashcompinit && bashcompinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
_fzf_complete_mix() {
  _fzf_complete --reverse --prompt="mix> " -- "$@" < <(
  command mix help
  )
}

_fzf_complete_mix_post() {
  awk '{print $2}'
}

# Git fixup with fzf
_fzf_complete_git() {
  _fzf_complete --color --preview '(echo {} | awk "{print \$1}" | xargs -I % git show --color=always %)' --preview-window=up:10:wrap --height 40% -- "$@" < <(
    git log --abbrev-commit --oneline
  )
}
_fzf_complete_git_post() {
  awk '{print $1}'
}

select-git-branch-with-fzf() {
    local branches branch
    branches=$(git for-each-ref --sort=committerdate refs/heads/ --format='%(refname:short)')
    branch=$(echo "$branches" | tac | fzf)
    if [[ -n $branch ]]; then
        LBUFFER+="$(echo $branch | tr -d '\n')"
        zle redisplay
    fi
    zle reset-prompt
}
zle -N select-git-branch-with-fzf
bindkey '^b' select-git-branch-with-fzf

select-git-hash-with-fzf() {
    local commits selected commit_hash
    commits=$(git lol)
    selected=$(echo "$commits" | fzf +m --height 40% --reverse \
        --preview 'git show --color=always {1}' \
        --preview-window=right:60%)
    if [[ -n $selected ]]; then
        commit_hash=$(echo "$selected" | awk '{print $1}')
        LBUFFER+="$(echo $commit_hash | tr -d '\n')"
        zle redisplay
    fi
    zle reset-prompt
}
zle -N select-git-hash-with-fzf
bindkey '^h' select-git-hash-with-fzf

# Search a file for a pattern added or removed in its history.
gitfzf() {
    local file="$1"
    local pattern="$2"

    if [[ -z "$file" || -z "$pattern" ]]; then
        echo "Usage: gitfzf <file> <pattern>"
        return 1
    fi

    git log -G "$pattern" --color=always -- "$file" |
    fzf --ansi --delimiter="\n" --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always"
}

# Custom git extensions
export PATH="$HOME/.git-extensions:$PATH"

# iTerm2 shell integration
if [ -f ~/.iterm2_shell_integration.zsh ]; then
  source ~/.iterm2_shell_integration.zsh
fi

#
source ~/.zshrc.d/second-brain.zsh

# Machine specific zshrc sourced here.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

if [[ -z "$SOURCED_ONCE" ]]; then
  export SOURCED_ONCE=1
  # Commands to run only the first time .zshrc is sourced
  if [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
    neofetch
  fi
fi

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship prompt
eval "$(starship init zsh)"

# Added by Windsurf
export PATH="/Users/andrewlechowicz/.codeium/windsurf/bin:$PATH"
