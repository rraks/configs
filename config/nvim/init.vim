"""""""""""""""""""""""""""""""""""
" rraks' NeoVim setup
""""""""""""""""""""""""""""""""""""

""""""""""""""""""
" Basic settings
""""""""""""""""""
" leader
let mapleader = "\<Space>"

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
filetype plugin indent on
" set termguicolors

" Global Clipboard
set clipboard+=unnamed


" Don't show mode in echo bar (for echodoc)
set noshowmode


" Don't display preview by default
set completeopt-=preview


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

" Toggle Quickfix
nnoremap <leader>q :call QFToggle()<cr>

" True Colors
set tgc

" nvim diff 
" Map dp and do for lines instead of blocks
nnoremap <silent> <leader>dp V:diffput<cr>
nnoremap <silent> <leader>dg V:diffget<cr>

" Quick Save
nnoremap <c-s> :w <CR>


" Space to clear highlight
nnoremap <c-h> :nohlsearch<Bar>:echo<CR>

" Star doesn't jump to the next match
nnoremap * *``

" Terminal Mappings
tnoremap <Esc> <C-\><C-n>

""""""""""""""""""
" Vim Plug
""""""""""""""""""

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'lervag/vimtex'
Plug 'majutsushi/tagbar'
Plug 'elzr/vim-json'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'simeji/winresizer'
Plug 'dhruvasagar/vim-zoom'
Plug 'rraks/pyro'
Plug 'dhruvasagar/vim-table-mode'
Plug 'voldikss/vim-floaterm'
Plug 'ap/vim-css-color'
Plug 'shougo/echodoc'
call plug#end()


""""""""""""""""""
" Appearances
""""""""""""""""""
" Keep dummy line to prevent LCN from messing view
set signcolumn=yes
" Relative Line numbers
" set number relativenumber
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" Theme
filetype plugin indent on
syntax enable
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox	
set background=dark


" Lightline
" Lightline
let g:lightline = {
			\ 'active': {
			\   'left': [ [ 'mode', 'paste'],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified', 'vimzoom'  ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'filetype' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head',
            \   'vimzoom': 'zoom#statusline'
			\ },
			\ }


""""""""""""""""""
" Tagbar
""""""""""""""""""
" Toggle Tagbar
nmap <leader><leader>t :TagbarToggle<CR>
nnoremap <leader>c :Commands <CR>



""""""""""""""""""
" VIM Latex 
""""""""""""""""""
let g:tex_conceal = ""
"<{}>"


""""""""""""""""""
" Vim-json
""""""""""""""""""
let g:vim_json_syntax_conceal = 0
" Consider `.jsonld` as JSON
autocmd BufNewFile,BufRead *.jsonld set filetype=json


""""""""""""""""""
" Vim-yaml
""""""""""""""""""
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab



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

tnoremap <a-a> <esc>a
tnoremap <a-b> <esc>b
tnoremap <a-d> <esc>d
tnoremap <a-f> <esc>f

" Commands history
nnoremap <leader>h :History: <CR>
" Search history
nnoremap <leader>s :History/ <CR>
" Normal mode Maps
nnoremap <leader>m :Maps <CR>
" Lines with search
nnoremap <leader>l :Lines <CR>
" Help
nnoremap <leader><leader>h :Helptags <CR>
" Rg
nnoremap <leader>r :Rg <CR>
" Buffers
nnoremap <leader>b :Buffers <CR>
" Files
nnoremap <leader>f :Files <CR>

""""""""""""""""""
" Easy motion
""""""""""""""""""
" Disable default mappings
let g:EasyMotion_do_mapping = 1
" s to start 2-searh
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" JK motions: Line motions

" EasyMotion
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)

""""""""""""""""""
" VimWiki
""""""""""""""""""
let g:vimwiki_list = [{'path': '~/.vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:conceallevel=3
let g:concealcursor="i"


""""""""""""""""""
" FloatTerm
""""""""""""""""""
let g:floaterm_position='center'
let g:floaterm_autoinsert=v:false
let g:floaterm_open_command='vsplit'

nnoremap <leader>t :FloatermToggle <CR>


""""""""""""""""""
" Pyro
""""""""""""""""""
let g:pyro_macro_path="/home/rraks/.vim/macros"



""""""""""""""""""
" Vim-Zoom
""""""""""""""""""
nmap <C-W>z <Plug>(zoom-toggle)


""""""""""""""""""
" Vim-Resizer
""""""""""""""""""
nnoremap <C-e> :WinResizerStartResize <CR>


""""""""""""""""""
" COC
""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
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

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

nnoremap <expr><C-f> coc#util#has_float() ? coc#util#float_scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#util#has_float() ? coc#util#float_scroll(0) : "\<C-b>"


" Snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)


inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction



""""""""""""""""""
" Language specific properties
""""""""""""""""""
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab