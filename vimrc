" Michael Jensen's vimrc
"
" This configuration is only tested and configured on Vim 8.2 and up.

" Check that current VIM instance is compatible
if &compatible || v:version < 802
  finish
endif

let g:mapleader = " "
map <CR> <Leader>

" Load filetype settings, plugins, and maps
filetype plugin indent on
syntax enable

" Default indent settings
" Defaults tweaked by filetype in vim/indent/ or vim/after/indent/
set autoindent     " Use indent of previous line on new lines
set expandtab      " Use spaces instead of tabs
set shiftwidth=4   " Indent with 4 spaces
set softtabstop=4  " Insert 4 spaces with the tab key

" Enable backspace to work over most edge cases
set backspace+=eol     " Line breaks
set backspace+=indent  " Spaces from 'autoindent'
set backspace+=start   " The start of the current insertion

" Wrap options
silent! set breakindent  " Indent wrapped lines
set showbreak=...        " Prefix wrapped rows with 3 dots
set linebreak            " Wrap lines at word boundaries

" Extra 'list' display character options
set list                   " Turn on list characters by default
set listchars=             " Clear the default listchars
set listchars+=tab:»\      " Tab characters, preserve width
set listchars+=extends:›   " Unwrapped text to screen right
set listchars+=precedes:‹  " Unwrapped text to screen left
set listchars+=trail:•     " Trailing spaces
set listchars+=nbsp:•      " Non-breaking spaces

" Appearance settings
set termguicolors       " Indicate that the terminal supports True Color
set background=light    " Default to light background
colorscheme PaperColor  " Default to PaperColor theme
set colorcolumn=89      " Mark the 89th char to suggest max line length at 88 (black)
set cursorline          " Show the line where the cursor is
if &term =~ "xterm"     " Make cursor a line on insert mode, but block otherwise
    let &t_SI = "\e[6 q"
    let &t_EI = "\e[2 q"
endif

" Set the cursor when entering VIM. I Tried setting the cursor manually, which
" works, but displays escape codes at the bottom of the screen. This solution
" avoids this problem.
if has("autocmd")
    au VimEnter * silent normal i
endif

" Move the viminfo into the vim directory
set viminfo+=n~/.config/vim/.viminfo

" Keep backups in one dir
set backup
set backupdir^=~/.vim/cache/backup

" Keep swapfiles in one dir
set directory^=~/.vim/cache/swap

" Keep undo files, if possible
if has('persistent_undo')
  set undofile
  set undodir^=~/.vim/cache/undo
endif

" Include settings (get rid of C defaults)
set path-=/usr/include  " Put filetype specific settings in filetypes
set include=

" Give a prompt instead of rejecting commands such as a risky :write
set confirm

" Use UTF-8 if we can and the env LANG doesn't specify that we shouldn't
if has('multi_byte') && !exists('$LANG') && &encoding ==# 'latin1'
  set encoding=utf-8
endif

" Delete comment leaders when joining lines
set formatoptions+=j

" Search Settings
set incsearch   " Show the search pattern while typing
set ignorecase  " Make the search case-insensitive by default
set smartcase   " Unless an uppercase character is in the pattern

" Don't add two spaces to the end of sentences on a join
set nojoinspaces

" Don't redraw the screen on macros, registers, nor other untyped commands
set lazyredraw

" New windows go below or right of a split
set splitbelow
set splitright

" Set the delay for key code sequences (not key mappings)
set ttimeoutlen=100

" Use s for [s]earch instead of [s]ubstitute
nnoremap s <nop>
nnoremap <silent> sf :Files<CR>
nnoremap <silent> sb :Buffers<CR>
nnoremap <silent> sj :Marks<CR>
nnoremap <silent> sm :Maps<CR>
nnoremap <silent> sh :Helptags<CR>
nnoremap <silent> ss :Snippets<CR>
nnoremap <silent> sg :GFiles<CR>
nnoremap <silent> sw :Windows<CR>
nnoremap <silent> sl :Lines<CR>
nnoremap <silent> sL :BLines<Space>
nnoremap <silent> sc :Commits<CR>
nnoremap <silent> sC :BCommits<CR>
nnoremap <silent> st :Filetypes<CR>

nnoremap <silent> q/ :History/<CR>
nnoremap <silent> q: :History:<CR>

" Hook fzf into ins-completion (i_Ctrl-x)
imap <C-x><C-l> <plug>(fzf-complete-line)
imap <C-x><C-f> <plug>(fzf-complete-path)

" Use common shell bindings in insert and command mode
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
inoremap <C-k> <C-o>D
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-e> <End>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-b> <Left>

" Use Fzf for completions where applicable
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')

" Run a shell command and insert in the current line
nnoremap <Leader>c i<C-r>=system('')<Left><Left>

" Configure WhichKey
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

nnoremap <silent> <leader>q :q!<CR>
let g:which_key_map.q = 'quit'
let g:which_key_map.w = ['w',   'write']
let g:which_key_map.a = ['wqa', ':wqa']

let g:which_key_map.f = { 'name' : '+format' }
nnoremap <leader>fa :EasyAlign<CR>
vnoremap <leader>fa :EasyAlign<CR>
let g:which_key_map.f.a = 'align'

let g:which_key_map.t = {
    \ 'name' : '+toggle',
    \ 'n' : [':set number!', 'line numbers'],
    \ }

let g:which_key_map.e = {
    \ 'name' : '+edit',
    \ 'v' : ['vimrc#edit()', 'vimrc'],
    \ }

let g:which_key_map.l = {
    \ 'name' : '+load',
    \ 'v' : ['vimrc#save_and_source()', 'vimrc'],
    \ }

let g:which_key_map.f = {
    \ 'name' : '+find',
    \ '/' : [':History/'     , 'history'],
    \ ';' : [':Commands'     , 'commands'],
    \ 'b' : [':BLines'       , 'current buffer'],
    \ 'B' : [':Buffers'      , 'open buffers'],
    \ 'c' : [':Commits'      , 'commits'],
    \ 'C' : [':BCommits'     , 'buffer commits'],
    \ 'f' : [':Files'        , 'files'],
    \ 'F' : [':Filetypes'    , 'file types'],
    \ 'g' : [':GFiles'       , 'git files'],
    \ 'G' : [':GFiles?'      , 'modified git files'],
    \ 'h' : [':History'      , 'file history'],
    \ 'H' : [':History:'     , 'command history'],
    \ 'l' : [':Lines'        , 'lines'],
    \ 'm' : [':Marks'        , 'marks'],
    \ 'p' : [':Helptags'     , 'help tags'],
    \ 's' : [':Snippets'     , 'snippets'],
    \ 'S' : [':Colors'       , 'color schemes'],
    \ 't' : [':Rg'           , 'text Rg'],
    \ 'w' : [':Windows'      , 'search windows'],
    \ 'z' : [':FZF'          , 'FZF'],
    \ }

let g:which_key_map.g = {
    \ 'name' : '+git' ,
    \ 'b' : [':Git blame',         'blame'],
    \ 's' : [':Git',               'status'],
    \ 'c' : [':Git commit',        'commit'],
    \ 'q' : [':GitGutterQuickFix', 'quickfix'],
    \ 'w' : [':GBrowse',           'browse'],
    \ }

let g:which_key_map.n = {
    \ 'name' : '+next' ,
    \ 'b' : [':bnext',             'buffer'],
    \ 'h' : [':GitGutterNextHunk', 'hunk (git)'],
    \ 'q' : [':cnext',             'quickfix'],
    \ }

let g:which_key_map.p = {
    \ 'name' : '+previous' ,
    \ 'b' : [':bprevious',         'buffer'],
    \ 'h' : [':GitGutterPrevHunk', 'hunk (git)'],
    \ 'q' : [':cprevious',         'quickfix'],
    \ }

vnoremap <leader>y "+y

" Register which key map
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")
