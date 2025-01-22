#!/bin/bash

set -e

# Step 1: Install Homebrew
echo "Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
fi

# Step 2: Install gum (required for interactivity and visuals)
echo "Checking for gum..."
if ! command -v gum &>/dev/null; then
  echo "gum is not installed. Installing gum using Homebrew..."
  brew install gum
else
  echo "gum is already installed."
fi

# Title using gum
gum style --foreground 212 --bold --border-foreground 212 --border normal --padding "1 2" "Dotfiles Setup Script"

# Step 3: Choose Tools to Install (default to all selected)
TOOLS=(
  git
  stow
  ghostty
  zsh
  zsh-syntax-highlighting
  starship
  gum
  bat
  mise
  wget
  gnu-sed
  gnupg
  gpg-suite
  jq
  lsd
  mas
  neovim
  neofetch
  zellij
  fzf
  git-delta
)

gum style --foreground 39 "Step 3: Selecting tools to install (default: all selected)..."
SELECTED_TOOLS=$(gum choose --no-limit --selected "${TOOLS[@]}")

if [[ -z "$SELECTED_TOOLS" ]]; then
  gum style --foreground 196 "No tools selected. Exiting..."
  exit 1
fi

gum style --foreground 39 "Installing selected tools..."
for tool in $SELECTED_TOOLS; do
  if ! brew list --formula | grep -q "^$tool\$"; then
    echo "Installing $tool..."
    brew install "$tool"
  else
    gum style --foreground 76 "$tool is already installed."
  fi
done

# Step 4: Clone Dotfiles Repository
REPO_URL="https://github.com/alecho/dot-files.git"
DEST_DIR="$HOME/.dot-files"

gum style --foreground 39 "Step 4: Setting up dotfiles repository..."
if [ -d "$DEST_DIR" ]; then
  gum confirm "Dotfiles repository already exists at $DEST_DIR. Do you want to pull the latest changes?" && {
    git -C "$DEST_DIR" pull
  } || {
    gum style --foreground 76 "Skipping repository update."
  }
else
  gum confirm "Dotfiles repository does not exist. Clone it?" && {
    git clone "$REPO_URL" "$DEST_DIR"
  } || {
    echo "Cannot continue without dotfiles repository. Exiting..."
    exit 1
  }
fi

# Step 5: Symlink Dotfiles with Stow
gum style --foreground 39 "Step 5: Creating symlinks using GNU Stow..."
cd "$DEST_DIR"
if ls -d */ &>/dev/null; then
  gum confirm "Do you want to create symlinks for all directories?" && {
    ls -d */ | xargs -I {} stow --adopt --target="$HOME" {}
    gum style --foreground 76 "Symlinks created successfully!"
  } || {
    gum style --foreground 76 "Skipping symlink creation."
  }
else
  gum style --foreground 196 "No directories found for stow. Skipping symlinks."
fi

# Step 6: Set up Neovim Configuration
gum style --foreground 39 "Step 6: Configuring Neovim..."
if [ -f "$HOME/.vimrc" ]; then
  mkdir -p "$HOME/.config/nvim"
  ln -sf "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
  gum style --foreground 76 "Linked .vimrc to Neovim init.vim."
else
  gum style --foreground 196 "No .vimrc file found. Skipping Neovim setup."
fi

# Final Message
gum style --foreground 46 --bold "Dotfiles setup is complete! Enjoy your new environment."
