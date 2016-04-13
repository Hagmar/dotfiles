#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

###  Vim ###

ln -sfv "$DIR/vim/.vimrc" ~

# Pathogen
echo "Updating Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
    echo "Error - could not install pathogen" >&2
    exit 1
fi

# Gundo
if [ ! -d ~/.vim/bundle/gundo ];then
    git clone https://github.com/sjl/gundo.vim.git ~/.vim/bundle/gundo
    if [ ! -d ~/.vim/bundle/gundo ];then
        echo "Error - could not install gundo" >&2
        exit 1
    fi
else
    echo "Updating Gundo"
    ( cd ~/.vim/bundle/gundo && git pull )
fi

# CtrlP
if [ ! -d ~/.vim/bundle/ctrlp.vim ];then
    git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
    if [ ! -d ~/.vim/bundle/ctrlp.vim ];then
        echo "Error - could not install CtrlP" >&2
        exit 1
    fi
else
    echo "Updating CtrlP"
    ( cd ~/.vim/bundle/ctrlp.vim && git pull )
fi

# NERD Commenter
if [ ! -d ~/.vim/bundle/nerdcommenter ];then
    git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
    if [ ! -d ~/.vim/bundle/nerdcommenter ];then
        echo "Error - could not install CtrlP" >&2
        exit 1
    fi
else
    echo "Updating NERD Commenter"
    ( cd ~/.vim/bundle/nerdcommenter && git pull )
fi
