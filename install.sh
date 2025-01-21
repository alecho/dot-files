#!/bin/bash

set -e

# Install Homebrew if not installed
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed."
fi

# Install essential tools using Homebrew
TOOLS=(
  git
  stow
  zsh
  zsh-syntax-highlighting
  starship
  gum
  bat
  mise
  wget
  gnu-sed
  gnupg
  jq
  lsd
  mas
  neovim
)

echo "Installing required tools..."
for tool in "${TOOLS[@]}"; do
  if ! brew list --formula | grep -q "^$tool\$"; then
    echo "Installing $tool..."
    brew install "$tool"
  else
    echo "$tool is already installed."
  fi
done

# Define repository URL
REPO_URL="https://github.com/alecho/dot-files.git"

# Define destination directory
DEST_DIR="$HOME/.dot-files"

# Clone the repository
if [ -d "$DEST_DIR" ]; then
  echo "Dotfiles repository already exists at $DEST_DIR. Pulling latest changes..."
  git -C "$DEST_DIR" pull
else
  echo "Cloning dotfiles repository to $DEST_DIR..."
  git clone "$REPO_URL" "$DEST_DIR"
fi

# Use Stow to create symlinks for dotfiles
echo "Creating symlinks for dotfiles using GNU Stow..."
cd "$DEST_DIR"
ls -d */ | xargs -I {} stow --target="$HOME" {}

# Neovim configuration setup
echo "Setting up Neovim configuration..."
mkdir -p "$HOME/.config/nvim"
if [ -f "$HOME/.vimrc" ]; then
  ln -sf "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
  echo "Linked .vimrc to Neovim init.vim"
else
  echo "No .vimrc file found. Skipping Neovim init.vim setup."
fi

echo "Dotfiles setup complete!"
