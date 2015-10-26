set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle.
Plugin 'gmarik/Vundle.vim'

"
" Custom plugins.
"

" A universal set of defaults that (hopefully) everyone can agree on.
Plugin 'tpope/vim-sensible'

" NERD tree allows you to explore your filesystem and to open files and
" directories.
Plugin 'scrooloose/nerdtree'

" Syntastic is a syntax checking plugin for Vim that runs files through
" external syntax checkers and displays any resulting errors to the user.
Plugin 'scrooloose/syntastic'

" Full path fuzzy file, buffer, mru, tag, ... finder for Vim
Plugin 'kien/ctrlp.vim'

" JavaScript bundle for vim, this bundle provides syntax and indent plugins.
Plugin 'pangloss/vim-javascript'

" One colorscheme pack to rule them all!
Plugin 'flazz/vim-colorschemes'

" VimOutliner is an outline processor with many of the same features as
" Grandview, More, Thinktank, Ecco, etc.
Plugin 'vimoutliner/vimoutliner'

" Supertab is a vim plugin which allows you to use <Tab> for all your insert
" completion needs.
Plugin 'ervandew/supertab'

" Causes all trailing whitespace characters (spaces and tabs) to be
" highlighted, and gives a :StripWhitespace function.
Plugin 'ntpeters/vim-better-whitespace'

" Easily align text with Tabular.vim.
Plugin 'godlygeek/tabular'

" A better markdown mode.
Plugin 'plasticboy/vim-markdown'

call vundle#end()
filetype plugin indent on

" Set the color scheme.
color oceanblack

" Case insensitive search.
set smartcase
set ic

" Enable tab completion.
set wildmode=longest,list,full
set wildmenu

" Two space indentation by default.
set shiftwidth=2
set tabstop=2

" Spaces instead of tabs.
set expandtab

" Wrap at 80 chars.
set textwidth=80

" Continue comments after hitting o, O and <Enter>
set formatoptions+=ro

" Recognize numbered lists.
set formatoptions+=n

" Enable vim highlighting.
set hlsearch

" Disable folding in markdown
let g:vim_markdown_folding_disabled=1

" Enable checkboxes and tags in VIM Outliner.
let g:vo_modules_load = "checkbox:tags"

" Make the double comma be the key.
let maplocalleader = ',,'

source ~/.vimrc-nerdtree
