" Set to vim mode
if &compatible
 set nocompatible
endif 


" Remapped Esc to <c-c>
inoremap <c-c> <Esc>

" Neovim python env
let g:python3_host_prog = '/home/thepro/anaconda3/bin/python'

" Backups
set backup
set backupdir=~/.vimbackup
au BufWritePre * let &bex = substitute(expand('%:p:h'), '/', ':', 'g') . strftime(';%FT%T')

" Leader
let mapleader = "\<Space>"

" Basic indentation configs
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set smartcase
set incsearch

" Global Clipboard
set clipboard+=unnamed

" Don't show mode in echo bar (for echodoc)
set noshowmode

" Relative Line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Terminal mode
tnoremap <Esc> <C-\><C-n>:q!<CR>

set completeopt-=preview


" nvim diff 
" Don't fold 
if &diff                             " only for diff mode/vimdiff
  set diffopt=filler,context:1000000 " filler is default and inserts empty lines for sync
endif
" Map dp and do for lines instead of blocks
nnoremap <silent> <Leader>dp V:diffput<cr>
nnoremap <silent> <Leader>dg V:diffget<cr>

" Space to clear highlight
nnoremap <silent> <leader>n :nohlsearch<Bar>:echo<CR>

" Keep dummy line to prevent LCN from messing view
set signcolumn=yes

" netrw preview file triggered by p 
let g:netrw_preview = 1

"Advanced plugins
" Vim Plug Plugins
call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
Plug 'Shougo/echodoc.vim'
Plug 'lervag/vimtex'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'majutsushi/tagbar'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'elzr/vim-json'
Plug 'tpope/vim-fugitive'
call plug#end()

" Theme
filetype plugin indent on
syntax enable
colorscheme gruvbox	
set background=dark
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" Deoplete enable on startup 
let g:deoplete#enable_at_startup = 1

" Rust for deoplete
let g:deoplete#sources#rust#racer_binary='/home/thepro/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/thepro/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#show_duplicates=1
let g:autofmt_autosave = 1


" Language Client
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsMaxSeverity = "Error"
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/anaconda3/bin/pyls'],
    \ 'go': ['bingo','-disable-func-snippet'],
    \ }
let g:LanguageClient_rootMarkers = {
        \ 'go': ['.git', 'go.mod'],
        \ }


let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_useVirtualText = 0

set hidden
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <F6> :copen<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


nnoremap <leader>g :call LCToggle()<cr>
let g:lc_toggle = 0
function! LCToggle()
    if g:lc_toggle
        call LanguageClient#exit()
        let g:lc_toggle = 0
    else
        call LanguageClient#startServer()
        let g:lc_toggle = 1
    endif
endfunction


" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" For conceal markers.
let g:neosnippet#enable_completed_snippet = 1
set conceallevel=1 concealcursor=niv
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


" VIM Latex 
let g:tex_conceal = ""


" TagBar
nmap <F8> :TagbarToggle<CR>

" Vim-json
let g:vim_json_syntax_conceal = 0

" Vim-yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

" FZF
" Commands
nnoremap <leader>c :Commands<CR>
" Commands History
nnoremap <leader>h :History:<CR>
