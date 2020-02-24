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

" JSX formatting.
Plugin 'mxw/vim-jsx'

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

" Coffee script mode.
Plugin 'kchmck/vim-coffee-script'

" TypeScript mode.
Plugin 'leafgarland/typescript-vim'

" JSX in TypeScript.
Plugin 'peitalin/vim-jsx-typescript'

" TypeScript auto-completion.
"Plugin 'Quramy/tsuquyomi'

" CSS3 mode.
Plugin 'hail2u/vim-css3-syntax'

call vundle#end()
filetype plugin indent on

" Enable syntax highlighting.
syntax on

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

" Continue comments/bullets after hitting o, O and <Enter>, and also include
" numbered lists.
au FileType * setlocal formatoptions=jncrolq

" Disable formatting of comments with gq in markdown.
au FileType markdown setlocal formatoptions-=q

" Format options: auto wrap text, but don't include the leader.
au FileType markdown setlocal formatoptions-=c
au FileType markdown setlocal formatoptions+=t

" Enable vim highlighting.
set hlsearch

" Disable folding in markdown.
"let g:vim_markdown_folding_disabled=1

" Fix indentation for markdown bullets.
let g:vim_markdown_new_list_item_indent = 2

" VimOutliner: Make the double comma be the key.
let maplocalleader = ',,'

" VimOutliner: Enable checkboxes and tags only, but no smart paste.
let vo_modules_load = "checkbox:tags"

" Use the 'jscs' javascript checker.
let g:syntastic_javascript_checkers=['jscs']
" let g:syntastic_markdown_checkers=['proselint']

" Python should be two spaces by default too.
au FileType python setl sw=2 sts=2 et

" Typescript stuff.
" Commented out because it totally breaks gvim.
" nnoremap <silent> <leader>h :echo tsuquyomi#hint()<CR>

" Automatically change working directory to the file's path.
set autochdir

source ~/.vimrc-nerdtree
