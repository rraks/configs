" Basic vimrc
set nocompatible              " be iMproved, required
" Remapped Esc to <c-c>
inoremap <c-c> <Esc>
" Leader 
let mapleader = "\<Space>"
" relative linenumbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" Hide highlights
nnoremap <silent> <leader>n :nohlsearch<Bar>:echo<CR>
set showmatch
set incsearch
set hlsearch
set smartcase
set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set ruler
set undolevels=1000
set backspace=indent,eol,start
set clipboard+=unnamed
