Dotfiles
========

This is my collection of [configuration files](http://dotfiles.github.io/).

Usage
-----

Pull the repository, and then create the symbolic links [using GNU
stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).

```bash
$ git clone git@github.com:alecho/dot-files.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow asdf git iTerm tmux vim zsh homebrew
```
Symlink neovim's init.vim to ~/.vimrc
```bash
mkdir -p ~/.config/nvim/init.vim
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim

```

Install vim-plug for neovim
```bash
# Neovim (~/.local/share/nvim/site/autoload)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

License
-------

[MIT](http://opensource.org/licenses/MIT).
