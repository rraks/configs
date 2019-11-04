""""""""""""""""""""""""""""""""""""
" rraks' NeoVim setup
""""""""""""""""""""""""""""""""""""

""""""""""""""""""
" Basic settings
""""""""""""""""""

" Remapped Esc to <c-c>
inoremap <c-c> <Esc>

" Neovim python env
let g:python3_host_prog = '/home/thepro/anaconda3/bin/python'

" Backups
set backup
set backupdir=~/.vimbackup
au BufWritePre * let &bex = substitute(expand('%:p:h'), '/', ':', 'g') . strftime(';%FT%T')
" Put below in crontab
" * * * * * find /home/thepro/.vimbackup/* -type f -name '*;*' -mtime +1 -delete

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

" Terminal mode
tnoremap <Esc> <C-\><C-n>:q!<CR>

" Don't display preview by default
set completeopt-=preview

" nvim diff 
" Map dp and do for lines instead of blocks
nnoremap <silent> <Leader>dp V:diffput<cr>
nnoremap <silent> <Leader>dg V:diffget<cr>

" Space to clear highlight
nnoremap <c-h> :nohlsearch<Bar>:echo<CR>

" netrw preview file triggered by p 
let g:netrw_preview = 1


""""""""""""""""""
" Vim Plug
""""""""""""""""""

call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/lightline.vim'
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
Plug 'junegunn/goyo.vim'
Plug 'easymotion/vim-easymotion'
call plug#end()


""""""""""""""""""
" Appearances
""""""""""""""""""
" Keep dummy line to prevent LCN from messing view
set signcolumn=yes
" Relative Line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Theme
filetype plugin indent on
syntax enable
colorscheme gruvbox	
set background=dark
" Lightline
let g:lightline = {
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'filetype' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head'
			\ },
			\ }


""""""""""""""""""
" Deoplete 
""""""""""""""""""

" Deoplete enable on startup 
let g:deoplete#enable_at_startup = 1

" Rust for deoplete
let g:deoplete#sources#rust#racer_binary='/home/thepro/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/thepro/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#show_duplicates=1
let g:autofmt_autosave = 1


""""""""""""""""""
" Language Client
""""""""""""""""""

let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsMaxSeverity = "Error"
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/anaconda3/bin/pyls'],
    \ 'go': ['bingo','-disable-func-snippet'],
    \ }
let g:LanguageClient_rootMarkers = {
        \ 'go': ['.git', 'go.mod'],
        \ }

" Language client appearances 
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_useVirtualText = 0

" Maps for Language client 
set hidden
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" Toggle Language Client
nnoremap <leader>g :call LCToggle()<cr>
let g:lc_toggle = 1
function! LCToggle()
    if g:lc_toggle
        call LanguageClient#exit()
        let g:lc_toggle = 0
    else
        call LanguageClient#startServer()
        let g:lc_toggle = 1
    endif
endfunction

" Toggle Quickfix
nnoremap <leader>q :call QFToggle()<cr>
let g:qf_toggle = 1
function! QFToggle()
    if g:qf_toggle
            :copen
        let g:qf_toggle = 0
    else
            :cclose
        let g:qf_toggle = 1
    endif
endfunction


""""""""""""""""""
" Neo-snippet
""""""""""""""""""
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" For conceal markers.
let g:neosnippet#enable_completed_snippet = 1
" set conceallevel=2 concealcursor=niv


""""""""""""""""""
" VIM Latex 
""""""""""""""""""
let g:tex_conceal = ""
"<{}>"


""""""""""""""""""
" TagBar
""""""""""""""""""
nmap <F8> :TagbarToggle<CR>


""""""""""""""""""
" Vim-json
""""""""""""""""""
let g:vim_json_syntax_conceal = 0


""""""""""""""""""
" Vim-yaml
""""""""""""""""""
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


""""""""""""""""""
" Echodoc
""""""""""""""""""
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'


""""""""""""""""""
" FZF
""""""""""""""""""
" Commands history
nnoremap <leader>c :Commands <CR>
" Commands history
nnoremap <leader>h :History: <CR>
" Search history
nnoremap <leader>s :History/ <CR>
" Normal mode Maps
nnoremap <leader>m :Maps <CR>
" Lines with search
nnoremap <leader>l :Lines <CR>
nnoremap <leader><leader>h :Helptags <CR>


""""""""""""""""""
" Easy motion
""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 1
" s to start 2-searh
nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
