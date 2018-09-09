" Set to vim mode
if &compatible
 set nocompatible
endif

"Basic configs
set tabstop=4
set shiftwidth=4
set expandtab

set number relativenumber
set clipboard+=unnamed

" Relative Line numbers
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

" Require for powerline
set noshowmode

" Space to clear highlight
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Keep dummy line to prevent LCN from messing view
sign define Dummy
autocmd VimEnter,SessionLoadPost,BufRead * execute 'sign place 97349278 line=9999 name=Dummy buffer='.bufnr('%')

" Set split to right for preview
augroup previewWindowPosition
   au!
   autocmd BufWinEnter * call PreviewWindowPosition()
augroup END
function! PreviewWindowPosition()
   if &previewwindow
      wincmd L
   endif
endfunction    

" No preview mode by default, <K> will bring it up
set completeopt-=preview



" Deoplete Plugins
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')
 call dein#add('~/.cache/dein')
 call dein#add('Shougo/deoplete.nvim')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif
 call dein#end()
 call dein#save_state()
endif



" Vim Plug Plugins
call plug#begin('~/.vim/plugged')
"Plug 'zchee/deoplete-jedi'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/echodoc.vim'
Plug 'autozimu/LanguageClient-neovim' 
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
call plug#end()


" Advance Configs

" Deoplete enable on startup 
let g:deoplete#enable_at_startup = 1

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/anaconda3/bin/pyls'],
    \ }
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>


" Neo Snippet 
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_completed_snippet = 1
" Marker concealment
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" SuperTab like snippets behavior.
imap <expr><TAB>
\ pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
