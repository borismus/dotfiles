" Set the guifont only on mac.
if has("gui_macvim")
  set guifont=Inconsolata:h17
endif

" Remove toolbar.
set guioptions-=T

" Remove scrollbar.
set guioptions-=r

" Always open NERDTree.
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Set the color scheme.
color wombat256mod

" Set vim outliner colors
hi BT1 guifg=#808080 ctermfg=0 gui=bold

" From this kuler scheme: https://goo.gl/AesRRw
hi OL1 guifg=#00C0F7 ctermfg=0 gui=bold
hi OL2 guifg=#23D4B3 ctermfg=0 gui=bold
hi OL3 guifg=#FD9100 ctermfg=0 gui=bold
hi OL4 guifg=#FFD258 ctermfg=0 gui=bold
hi OL5 guifg=#DB9E9E ctermfg=0 gui=bold

" Set the default size of the editor.
set lines=35 columns=120

" Show the gutter after column 80.
set textwidth=80
set colorcolumn=+1
hi ColorColumn guibg=#2d2d2d ctermbg=246
