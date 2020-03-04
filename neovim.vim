""""""""""""""""""""""""""""""""""""
" rraks' NeoVim setup
""""""""""""""""""""""""""""""""""""

""""""""""""""""""
" Basic settings
""""""""""""""""""

" Neovim python env
let g:python3_host_prog = '/home/rraks/venvs/sci/bin/python'

" Backups
set backup
set backupdir=~/.vimbackup
au BufWritePre * let &bex = substitute(expand('%:p:h'), '/', ':', 'g') . strftime(';%FT%T')
" Put below in crontab
" * * * * * find /home/rraks/.vimbackup/* -type f -name '*;*' -mtime +1 -delete


" Basic indentation configs
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set smartcase
set incsearch
set termguicolors

" Global Clipboard
set clipboard+=unnamed


" Don't show mode in echo bar (for echodoc)
set noshowmode


" Don't display preview by default
set completeopt-=preview

set hidden

" netrw preview file triggered by p 
let g:netrw_preview = 1

" Quickfix toggle
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

" True Colors
set tgc


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
Plug 'vimwiki/vimwiki'
Plug 'junegunn/vim-peekaboo'
Plug 'rraks/pyro'
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
let g:gruvbox_contrast_dark='hard'
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
let g:deoplete#sources#rust#racer_binary='/home/rraks/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/home/rraks/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#show_duplicates=1
let g:autofmt_autosave = 1



""""""""""""""""""
" Language Client
""""""""""""""""""

let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsMaxSeverity = "Error"
let g:LanguageClient_serverCommands = {
    \ 'python': ['/home/rraks/venvs/sci/bin/pyls'],
    \ 'go': ['/home/rraks/go/bin/gopls'],
    \ }
let g:LanguageClient_rootMarkers = {
        \ 'go': ['.git', 'go.mod'],
        \ }

" Language client appearances 
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_useVirtualText = "CodeLens"


" Toggle Language Client
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


""""""""""""""""""
" NVIM-LSP
""""""""""""""""""


""""""""""""""""""
" Neo-snippet
""""""""""""""""""
" Plugin key-mappings.
" For conceal markers.
let g:neosnippet#enable_completed_snippet = 1
" set conceallevel=2 concealcursor=niv


""""""""""""""""""
" VIM Latex 
""""""""""""""""""
let g:tex_conceal = ""
"<{}>"


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
" Files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \           fzf#vim#with_preview(), <bang>0)

" Floating window
set winblend=0

hi NormalFloat guibg=None
if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
endif

if stridx($FZF_DEFAULT_OPTS, '--border') == -1
    let $FZF_DEFAULT_OPTS .= ' --border'
endif

function! FloatingFZF()
    let width = float2nr(&columns * 0.8)
    let height = float2nr(&lines * 0.6)
    let opts = { 'relative': 'editor',
               \ 'row': (&lines - height) / 2,
               \ 'col': (&columns - width) / 2,
               \ 'width': width,
               \ 'height': height }

    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
endfunction

let g:fzf_layout = { 'window': 'call FloatingFZF()' }



""""""""""""""""""
" Easy motion
""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 1
" s to start 2-searh
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions



""""""""""""""""""
" VimWiki
""""""""""""""""""
let g:vimwiki_list = [{'path': '~/.vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:conceallevel=3
let g:concealcursor="i"


""""""""""""""""""
" Floating term
""""""""""""""""""
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  let height = float2nr((&lines - 2) * 0.7)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.7)
  let col = float2nr((&columns - width) / 2)
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:Normal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction

""""""""""""""""""
" Pyro
""""""""""""""""""
let g:pyro_macro_path="/home/rraks/.vim/macros"



""""""""""""""""""
" Insert Mappings
""""""""""""""""""
" Remapped Esc to <c-c>
inoremap <c-c> <Esc>

" Quick save
inoremap <c-s> <Esc> :w <CR>

""""""""""""""""""
" Normal Mappings
""""""""""""""""""

" Quick Save
nnoremap <c-s> :w <CR>

" LanguageClient 
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Space to clear highlight
nnoremap <c-h> :nohlsearch<Bar>:echo<CR>

" Star doesn't jump to the next match
nnoremap * *``


""""""""""""""""""
" Leader Mappings
""""""""""""""""""
" leader
let mapleader = "\<Space>"

" nvim diff 
" Map dp and do for lines instead of blocks
nnoremap <silent> <leader>dp V:diffput<cr>
nnoremap <silent> <leader>dg V:diffget<cr>

" LanguageClient
nnoremap <leader><leader>g :call LCToggle()<cr>

" Toggle Quickfix
nnoremap <leader>q :call QFToggle()<cr>

" Toggle Tagbar
nmap <leader>t :TagbarToggle<CR>
nnoremap <leader>c :Commands <CR>

" FZF
" Commands history
nnoremap <leader>h :History: <CR>
" Search history
nnoremap <leader>s :History/ <CR>
" Normal mode Maps
nnoremap <leader>m :Maps <CR>
" Lines with search
nnoremap <leader>l :Lines <CR>
nnoremap <leader><leader>h :Helptags <CR>
" Rg
nnoremap <leader>r :Rg <CR>

" EasyMotion
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)

" Neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)


""""""""""""""""""
" Terminal Mappings
""""""""""""""""""
tnoremap <Esc> <C-\><C-n>

