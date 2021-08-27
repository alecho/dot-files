#!/usr/bin/env bash

# Erlang - https://github.com/asdf-vm/asdf-erlang
brew install autoconf openssl wxmac
asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git

# Elixir - https://github.com/asdf-vm/asdf-elixir
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

# Ruby - https://github.com/asdf-vm/asdf-ruby
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

# NodeJS - https://github.com/asdf-vm/asdf-nodejs
brew install gpg
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# Python
asdf plugin-add python

# Yarn
asdf plugin-add yarn https://github.com/twuni/asdf-yarn
