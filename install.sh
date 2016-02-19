#!/bin/bash

here=$PWD

#--- Make links in the home folder to the dot files in this folder
for file in  ".tmux.conf" ".vimrc" ".xmodmap" ".Xdefaults"; 
do
    if [[ $(readlink -f $HOME/$file) != $(readlink -f $here/$file) ]]; then
        ln -i -s -T $here/$file $HOME/$file
        echo "linked $file"
    fi
done

#--- Vim
# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Clone the repos with vim plugins
git clone https://github.com/vim-scripts/Align.git ~/.vim/bundle/Align
git clone https://github.com/LaTeX-Box-Team/LaTeX-Box.git ~/.vim/bundle/Latex-Box
git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
git clone https://github.com/scrooloose/syntastic.git ~/.vim/bundle/syntastic
git clone https://github.com/bling/vim-airline.git ~/.vim/bundle/vim-airline
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
git clone https://github.com/vim-scripts/SearchComplete.git ~/.vim/bundle/SearchComplete
git clone https://github.com/vim-scripts/TaskList.vim ~/.vim/bundle/TaskList.vim
git clone https://github.com/vim-scripts/mru.vim ~/.vim/bundle/mru.vim

