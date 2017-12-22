"==============================================================="
"                              Plugins
"==============================================================="
"
" Disable behaviour like vi, must be the first line!!!!
set nocompatible              " be iMproved, required

filetype off                  " required for vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

Plugin 'vim-scripts/Align.git'
Plugin 'lervag/vimtex.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'bling/vim-airline.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'vim-scripts/SearchComplete.git'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'vim-scripts/mru.vim'
Plugin 'jceb/vim-orgmode'
Plugin 'ervandew/supertab'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'SirVer/ultisnips' "Snippets engine
Plugin 'honza/vim-snippets' " Snippets from third party
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


"==============================================================="
"                          General Settings
"==============================================================="


"will replace backslashes with forward slashes when expanding file names
set shellslash

"Line Numbers
set number
set relativenumber

" Highlight cursor line
set cursorline
" Highlight cursor column
set cursorcolumn

" show the command in the bottom left corner of the screen
set showcmd

"Enable mouse in the CLI
set mouse=a

"Enable Backspace in insert mode
set backspace=2

" Syntax highlight
syntax on

set noerrorbells

filetype plugin on " enables filetype specific plugins

"Color Scheme
if has('gui_running')
    colo wombatJAM
    "colo herald
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove scrollbar on the right
else
    set t_Co=256
    colorscheme herald
endif

"Search
set hlsearch
set incsearch "Incremental Search

"Turn off text warp
set tw=0 wrap linebreak

"Identing
filetype indent on         " enables filetype specific identation
set smartindent            " Smartly autoindents
set expandtab			   " Convert Tab to spaces
set tabstop=4              " Tab is 4 spaces
set shiftwidth=4           " Number of spaces of autoindent


"Automatically save and load folds
set viewoptions-=options
augroup vimrc
    autocmd BufWritePost *
                \   if expand('%') != '' && &buftype !~ 'nofile'
                \|      mkview
                \|  endif
    autocmd BufRead *
                \   if expand('%') != '' && &buftype !~ 'nofile'
                \|      silent loadview
                \|  endif
augroup END

" Hide the mouse pointer while typing
set mousehide

" Make the command-line completion better
set wildmenu

" Airline Config
set laststatus=2
set encoding=utf-8
if has('gui_running')
    "let g:airline_powerline_fonts = 1
endif

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"


"Automatically change the current directory
set autochdir


"==============================================================="
"                       General Keybindings
"==============================================================="

"Remap ESC key
"inoremap <Tab> <Esc>
"ino jj <esc>
"cno jj <c-c>

ino jk <esc>
cno jk <c-c>



let mapleader="," "change the leader to be a comma vs slash

"Load Most Recently Used Files
map <F2> :MRU<kEnter>

"clear last search highlighting
nmap <C-h> :noh<kEnter>


"Paste over a visually selected area without having the selection placed in the default register
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

" shortcuts for copying to clipboard
nmap <leader>y "+y

" copy the current line to the clipboard
nmap <leader>yy "+Y
nmap <leader>Y "+Y
nmap <leader>p "+p

"Remap keys to delete without saving in the register
noremap d "_d
noremap dd "_dd
noremap D "_D
noremap s "_s



"==============================================================="
"                              Spellcheck
"==============================================================="
au BufNewFile,BufRead *.tex :setlocal spell
au BufNewFile,BufRead *.bib :setlocal spell
au FileType mail :setlocal spell
"map <F4> <Esc>:setlocal spl=pt spell<kEnter>


"==============================================================="
"                                LaTeX
"==============================================================="
"Remap movement keys
au BufRead,BufNewFile *.tex noremap <buffer> j gj
au BufRead,BufNewFile *.tex noremap <buffer> k gk
au BufRead,BufNewFile *.tex noremap <buffer> 0 g0
au BufRead,BufNewFile *.tex noremap <buffer> $ g$

"==============================================================="
"                         Org files                              "
"==============================================================="
"Remap movement keys
au BufRead,BufNewFile *.org noremap <buffer> j gj
au BufRead,BufNewFile *.org noremap <buffer> k gk
au BufRead,BufNewFile *.org noremap <buffer> 0 g0
au BufRead,BufNewFile *.org noremap <buffer> $ g$

"==============================================================="
"                         UltiSnips                              "
"==============================================================="
" Trigger configuration.
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
