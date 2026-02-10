# General Aliases

# Navigation
alias c='claude'
alias code='cd ~/Code'
alias dot='cd ~/dotfiles'
alias des='cd ~/Desktop'

# Clipboard
alias pbp='pbpaste'
alias pbc='pbcopy'
# Copy the last command to the clipboard
alias clc="fc -ln -1 | awk '{\$1=\$1}1' ORS='' | pbcopy"

# Tools
alias sm="awk 'NF{sum+=\$1} END {print sum}'"
alias cat="bat"
alias vim='nvim'
alias lcat='lolcat'
alias f="python select_and_run_command.py"
alias ff='print -z $(fzf)'

# Original ls backups
alias ols='ls'
alias oll='ls -Algosh'

# lsd tree aliases
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
alias vimzl='vim ~/.zshrc.d/local.zsh'
alias vimzellij='vim ~/.config/zellij/config.kdl'
alias vimg='vim ~/.gitconfig'
alias vimgi='vim ~/.gitignore_global'
alias vimm='vim ~/mise.toml'
alias vimml='vim mise.local.toml'
alias vimw='vim ~/scripts/work.rb'
alias vims='vim ~/.config/starship.toml'
alias vimsshc='vim ~/.ssh/config'

alias reload='source ~/.zshrc'

# Work script
alias work='ruby ~/scripts/work.rb'

# Ruby Gem
alias gin="cat ~/.default-gems | xargs gem install"
alias gup=gin
alias gun="gem uninstall"
alias gli="gem list"

# Terraform
alias tfp='terraform plan -out=current.plan'
alias tfa='terraform apply -input=true current.plan'

# Zellij
alias zel='zellij'
