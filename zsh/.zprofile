# .zprofile - Login shell environment setup
# This file is sourced for login shells and affects all child processes

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

# Specify an editor
export EDITOR='nvim'

# Notes
export NOTES_DIR=$HOME/Documents/Notes/
export ZK_NOTEBOOK_DIR=$NOTES_DIR/daily/

# GPG tty
export GPG_TTY=$(tty)

# bat
export BAT_THEME=Dracula

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

# Language env
export LSCOLORS="excxbxdxBxEgEdxbxgxcxd"

# Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# MySQL mysql2 gem
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib -L/opt/homebrew/opt/zstd/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include -I/opt/homebrew/opt/zstd/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig:/opt/homebrew/opt/zstd/lib/pkgconfig"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Golang
export PATH=$PATH:$HOME/go/bin

## Scripts
PATH=$PATH:$HOME/scripts

## Bun.js
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Docker CLI
export PATH="$HOME/.docker/bin:$PATH"

# Custom git extensions
export PATH="$HOME/.git-extensions:$PATH"

# Zsh/Oh My Zsh configuration
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh/custom
export UPDATE_ZSH_DAYS=60

# FZF configuration
export FZF_DEFAULT_COMMAND="ag -gi --hidden --silent"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--keep-right --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --bind=ctrl-j:preview-page-down,ctrl-k:preview-page-up'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --theme=Dracula {}"'
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='--border --info=inline'

# mise version manager
eval "$(mise activate zsh)"

# Added by Windsurf
export PATH="/Users/andrewlechowicz/.codeium/windsurf/bin:$PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
