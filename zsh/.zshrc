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

## Completions
### Enable bash completions in zsh
#autoload -U +X bashcompinit && bashcompinit

### Check if compinit is already loaded, if not, load it
if ! type "_comps" > /dev/null; then
  autoload -Uz +X compinit && compinit
fi

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Specify an editor
export EDITOR='nvim'
alias vim='nvim'

# Notes
export ZK_NOTEBOOK_DIR=$HOME/Documents/Notes/daily/

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

autoload -Uz +X compdef && compdef _zk zk

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
# export ASDF_PYTHON_PATCH_URL="https://github.com/python/cpython/commit/8ea6353.patch?full_index=1"

# FZF
# <C-t> runs $FZF_CTRL_T_COMMAND
# vim ``<tab> runs _fzf_compgen_path()
# cd ``<tab> runs _fzf_compgen_dir()
# Default command to use when input is tty
export FZF_DEFAULT_COMMAND="ag -gi --hidden --silent"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--keep-right --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
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
  # Run the previous command and store exit status
  STATUS=$?
  # Check if the last command exited with 0 success code
  if [ $STATUS -eq 0 ]; then
    # Run the command if the last command was successful
    open raycast://confetti
  fi
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
plugins=(git docker gitfast macos bundler ruby rails)

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

alias pbp='pbpaste'
alias pbc='pbcopy'
## Copy the last command to the clipboard
alias clc='fc -ln -1 | awk '\''{$1=$1}1'\'' ORS='\'''\'' | pbcopy'

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
alias vimzl='vim ~/.zshrc.local'
alias vimzellij='vim ~/.config/zellij/config.kdl'
alias vimg='vim ~/.gitconfig'
alias vimgi='vim ~/.gitignore_global'
alias vimw='vim ~/scripts/work.rb'
alias vims='vim ~/.config/starship.toml'
alias reload='source ~/.zshrc'

## Git
alias gits='git status -sb'

## Work script
alias work='ruby ~/scripts/work.rb'

## Vim edit mode
bindkey -v

## Control + vim movement to simulate arrow key funtion
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
# Run the following to remove the quarantine on chromedriver.
# xattr -d com.apple.quarantine /usr/local/bin/chromedriver

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $HOME/.asdf/installs/terraform/0.12.29/bin/terraform terraform

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
    # Fetch commits
    commits=$(git lol)
    # Use fzf for selection with preview
    selected=$(echo "$commits" | fzf +m --height 40% --reverse \
        --preview 'git show --color=always {1}' \
        --preview-window=right:60%)
    # Extract only the commit hash from the selected line
    if [[ -n $selected ]]; then
        commit_hash=$(echo "$selected" | awk '{print $1}')
        LBUFFER+="$(echo $commit_hash | tr -d '\n')"
        zle redisplay
    fi
    zle reset-prompt
}
zle -N select-git-hash-with-fzf
bindkey '^h' select-git-hash-with-fzf

# Search a file for a pattern added or removed in it's history.
gitfzf() {
    local file="$1"
    local pattern="$2"

    # Check if both arguments are provided
    if [[ -z "$file" || -z "$pattern" ]]; then
        echo "Usage: gitfzf <file> <pattern>"
        return 1
    fi

    # Use git log with -G to filter commits by pattern in the diffs
    # Then, use fzf for selection, with previews showing commit messages and diffs
    git log -G "$pattern" --color=always -- "$file" |
    fzf --ansi --delimiter="\n" --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git show --color=always"
}


# iTerm2 shell integration
if [ -f ~/.iterm2_shell_integration.zsh ]; then
  source ~/.iterm2_shell_integration.zsh
fi

# Machine specific zshrc sourced here.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

if [[ -z "$SOURCED_ONCE" ]]; then
  export SOURCED_ONCE=1
  # Commands to run only the first time .zshrc is sourced

  # Run neofetch if not in tmux and in interactive mode
  if [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
    neofetch
  fi
fi

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"
