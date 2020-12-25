" Plugins
" ------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')
    Plug 'itchyny/lightline.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
call plug#end()
" ------------------------------------------------------------------



" Theme
" ------------------------------------------------------------------
set termguicolors

let g:lightline = { 'colorscheme' : 'challenger_deep' }
colorscheme challenger_deep
" ------------------------------------------------------------------



" Settings
" ------------------------------------------------------------------
filetype plugin indent on

" show existing tab with 4 spaces with
set tabstop=4
set shiftwidth=4

" on pressing tab, insert 4 spaces
set expandtab

set number
set nowrap

" auto indent
set ai
" ------------------------------------------------------------------
  

