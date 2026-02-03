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
