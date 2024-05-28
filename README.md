# Dotfiles

This is my collection of [configuration files](http://dotfiles.github.io/).

## Installation

1. Install homebrew with

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Install groups of homebrew packages

```language
/usr/local/bin/brew install
asdf
bat
direnv
fd
git
gnu-sed
gnupg
jq
lsd
mas
ms-jpq/sad/sad
neovim
reattach-to-user-namespace
ssh-copy-id
starship
stow
the_silver_searcher
tig
tldr-pages/tldr/tldr
tmuxinator
tree
wget
zsh
zsh-syntax-highlighting

``````
Pull the repository, and then create the symbolic links [using GNU
stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).

```bash
$ git clone git@github.com:alecho/dot-files.git ~/.dotfiles
$ cd ~/.dotfiles
$ ls -d */ | xargs stow
```
Symlink neovim's init.vim to ~/.vimrc
```bash
mkdir -p ~/.config/nvim/init.vim
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim

```

## License

[MIT](http://opensource.org/licenses/MIT).
