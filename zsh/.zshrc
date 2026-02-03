# ZSH/OMZ options
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git docker gitfast macos bundler ruby rails)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Source modular configs
for file in ~/.zshrc.d/*.zsh; do
  source "$file"
done

# iTerm2 shell integration
if [ -f ~/.iterm2_shell_integration.zsh ]; then
  source ~/.iterm2_shell_integration.zsh
fi

# First-run commands
if [[ -z "$SOURCED_ONCE" ]]; then
  export SOURCED_ONCE=1
  # Commands to run only the first time .zshrc is sourced
  if [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
    neofetch
  fi
fi

# Tool initializations (order matters)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# mise version manager (also in .zprofile for login shells)
eval "$(mise activate zsh)"

# Starship prompt
eval "$(starship init zsh)"

export PATH=/Users/andrewlechowicz/.local/bin:$PATH
