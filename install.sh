#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


### Nvim ###
mkdir -p "$HOME/.config/nvim"
ln -sfv "$DIR/nvim/init.vim" "$HOME/.config/nvim"

# Vim Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


###  Vim ###

ln -sfv "$DIR/vim/.vimrc" ~
