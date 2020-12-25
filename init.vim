" Plugins
call plug#begin(stdpath('data') . '/plugged')
    Plug 'itchyny/lightline.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
call plug#end()


" Theme
set termguicolors
syntax enable

let g:lightline = { 'colorscheme' : 'challenger_deep' }
colorscheme challenger_deep


" Settings
filetype plugin indent on


" Show existing tab with 4 spaces with
set softtabstop=4
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set number
set nowrap
" Auto indent
set ai
set title
set cursorline
set cmdheight=1
filetype plugin indent on


