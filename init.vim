" Plugins
" ---------------------------------------------
call plug#begin(stdpath('data') . '/plugged')
" Lightline bar and tabs
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Navigate between tmux panes from vim
Plug 'christoomey/vim-tmux-navigator'

" Themes
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
Plug 'atelierbram/Base2Tone-vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'n1ghtmare/noirblaze-vim'

" Searching for files in vim (mapped to Ctrl+p)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Typescript/HTML/CSS/JSON auto-completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'OmniSharp/omnisharp-vim'
Plug 'dense-analysis/ale'

" Syntax highlighting for various languages
Plug 'sheerun/vim-polyglot'

" Javascript syntax support
"Plug 'pangloss/vim-javascript'
" TypeScript syntax support
"Plug 'leafgarland/typescript-vim'
" JSX syntax support
"Plug 'maxmellon/vim-jsx-pretty'
" C# auto-completion
call plug#end()



" Theme
" ---------------------------------------------
set termguicolors
syntax enable

" Netrw Settings
let g:netrw_liststyle = 3

" Let buffers be clickable
let g:lightline#bufferline#clickable=1
let g:lightline#bufferline#shorten_path=1
let g:lightline#bufferline#min_buffer_count=1

let g:lightline = {
      \ 'colorscheme': 'noirblaze',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [''] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \}

"let g:gruvbox_contrast_dark = 'hard'
colorscheme noirblaze



" Settings
" ---------------------------------------------
filetype plugin indent on
" Map Leader key to Space
nnoremap <SPACE> <Nop>
let mapleader = " "
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
" Set scroll offfset 
set scrolloff=8
" Disable auto text line wrapping
set formatoptions+=t
set tw=0
set mouse=a
" File/Buffer navigation/search and Git nav
nnoremap <C-p> :Files<Cr>
nnoremap <C-e> :Rg<Cr>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-h> :History<CR>
nmap <Leader>g :GFiles<CR>
nmap <Leader>g? :GFiles?<CR>
" Shortcuts for switching between splits 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Format the whole file (F7 key)
map <F7> gg=G<C-o><C-o>
" Turn hybrid line numbers on
set number relativenumber
set nu rnu
" Turn hybrid line numbers off
"set nonumber norelativenumber
"set nonu nornu
"Unset the "last search pattern" register by hitting enter
nnoremap <CR> :noh<CR><CR>
" Get rid of bells, who would want this?!
set noerrorbells
" Keeping history
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile


" WSL Settings
" ---------------------------------------------
" Check if we're running on WSL
function! Is_WSL() abort
  let proc_version = '/proc/version'
  return filereadable(proc_version)
        \  ? !empty(filter(
        \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
        \  : v:false
endfunction

" WSL yank support
if Is_WSL()
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
        augroup END
    end
end



" Fzf Settings
" ---------------------------------------------
"  Match the colors with the current colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }



" Coc Settings (DEFAULTS)
" ---------------------------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" NOTE: Uncomment the line below after upgrading to nvim 0.5.5 (still in alpha at the time of writing this)
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" NOTE: The below interferes with my NERDTree shortcuts, disabled for the time
" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Coc Extensions to be installed when nvim starts
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-omnisharp', 'coc-html', 'coc-css' ]

"let g:ale_linters = { 'cs': ['OmniSharp'] }


"" OmniSharp Settings (DEFAULT)
"" ---------------------------------------------
"let g:OmniSharp_highlighting = 0
"
"" Use fzf
"let g:OmniSharp_selector_ui = 'fzf'    
"let g:OmniSharp_selector_findusages = 'fzf'
"
"" Don't autoselect first omnicomplete option, show options even if there is only
"" one (so the preview documentation is accessible). Remove 'preview', 'popup'
"" and 'popuphidden' if you don't want to see any documentation whatsoever.
"" Note that neovim does not support `popuphidden` or `popup` yet:
"" https://github.com/neovim/neovim/issues/10996
"if has('patch-8.1.1880')
"  set completeopt=longest,menuone,popuphidden
"  " Highlight the completion documentation popup background/foreground the same as
"  " the completion menu itself, for better readability with highlighted
"  " documentation.
"  set completepopup=highlight:Pmenu,border:off
"else
"  set completeopt=longest,menuone,preview
"  " Set desired preview window height for viewing documentation.
"  set previewheight=5
"endif
"
"" Tell ALE to use OmniSharp for linting C# files, and no other linters.
"let g:ale_linters = { 'cs': ['OmniSharp'] }
"
"augroup omnisharp_commands
"  autocmd!
"
"  " Show type information automatically when the cursor stops moving.
"  " Note that the type is echoed to the Vim command line, and will overwrite
"  " any other messages in this space including e.g. ALE linting messages.
"  autocmd CursorHold *.cs OmniSharpTypeLookup
"
"  " The following commands are contextual, based on the cursor position.
"  autocmd FileType cs nmap <silent> <buffer> <Leader>gd <Plug>(omnisharp_go_to_definition)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>gr <Plug>(omnisharp_find_usages)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>gi <Plug>(omnisharp_find_implementations)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_definition)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>pr <Plug>(omnisharp_preview_implementations)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>fs <Plug>(omnisharp_find_symbol)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>fx <Plug>(omnisharp_fix_usings)
"  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
"  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
"
"  " Navigate up and down by method/property/field
"  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
"  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
"  " Find all code errors/warnings for the current solution and populate the quickfix window
"  autocmd FileType cs nmap <silent> <buffer> <Leader>gcc <Plug>(omnisharp_global_code_check)
"  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
"  autocmd FileType cs xmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
"  " Repeat the last code action performed (does not use a selector)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
"  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
"
"  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)
"
"  autocmd FileType cs nmap <silent> <buffer> <F2> <Plug>(omnisharp_rename)
"
"  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
"  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
"augroup END
