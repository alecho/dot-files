# Vim Mode & Key Bindings

# Enable vim edit mode
bindkey -v

# Control + vim movement to simulate arrow key function
bindkey '^k' up-line-or-beginning-search
bindkey '^l' vi-forward-char
bindkey '^j' down-line-or-beginning-search
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^w' vi-forward-word

# FZF widgets (defined in fzf.zsh, bound here to survive bindkey -v reset)
bindkey '^b' select-git-branch-with-fzf
bindkey '^x^h' select-git-hash-with-fzf
