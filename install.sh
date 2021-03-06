#!/bin/bash

here=$PWD

#--- Make links in the home folder to the dot files in this folder
for file in  ".tmux.conf" ".vimrc" ".Xmodmap" ".Xdefaults" ".bashrc" ".i3/config" \
    ".i3/i3blocks.conf" ".doom.d/config.el" ".doom.d/init.el" ".doom.d/packages.el" \
    ".doom.d/settings.org" ".alacritty.yml", ".scripts/changeCaps.sh"; 
do
    if [[ $(readlink -f $HOME/$file) != $(readlink -f $here/$file) ]]; then
        ln -i -s -T $here/$file $HOME/$file
        echo "linked $file"
    fi
done

#--- General usage Stuff
# FZF - General use fuzzyfinder, works with vim as well by doing :FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

#--- Vim
# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall! +qall
