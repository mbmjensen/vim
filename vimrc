" Michael Jensen's vimrc
"
" This configuration is only tested and configured on Vim 8.2 and up.

" Check that current VIM instance is compatible
if &compatible || v:version < 802
  finish
endif

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
if exists('+termguicolors')
  let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"    " Fix true color support for tmux, see
  let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"    " https://github.com/tmux/tmux/issues/1246#issue-292083184
  set termguicolors                         " Indicate that the terminal supports True Color
endif

set background=light   " Default to light background
colorscheme PaperColor " Default to PaperColor theme
set signcolumn=number  " Merge the signcolumn and the number when the number column is active
set cursorline         " Show the line where the cursor is
set colorcolumn=89     " Mark the 89th char to suggest max line length at 88 (black)

if &term =~ 'xterm' || &term =~ 'screen'    " Make cursor a line on insert mode, but block otherwise
    let &t_SI = "\<esc>[6 q"
    let &t_EI = "\<esc>[2 q"
endif

" Set the cursor when entering VIM. I Tried setting the cursor manually, which
" works, but displays escape codes at the bottom of the screen. This solution
" avoids this problem.
if has('autocmd')
    autocmd VimEnter * silent normal i
endif

" Move the viminfo into the vim directory (n denotes name of viminfo file)
set viminfo+=n~/.vim/.viminfo

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
nnoremap <silent> sf :Files<cr>
nnoremap <silent> sb :Buffers<cr>
nnoremap <silent> sj :Marks<cr>
nnoremap <silent> sm :Maps<cr>
nnoremap <silent> sh :Helptags<cr>
nnoremap <silent> ss :Snippets<cr>
nnoremap <silent> sg :GFiles<cr>
nnoremap <silent> sw :Windows<cr>
nnoremap <silent> sl :Lines<cr>
nnoremap <silent> sL :BLines<cr>
nnoremap <silent> sc :Commits<cr>
nnoremap <silent> sC :BCommits<cr>
nnoremap <silent> st :Filetypes<cr>

nnoremap <silent> q/ :History/<cr>
nnoremap <silent> q: :History:<cr>

" Hook fzf into ins-completion (i_Ctrl-x)
imap <C-x><C-l> <plug>(fzf-complete-line)
imap <C-x><C-f> <plug>(fzf-complete-path)

" Use common shell bindings in insert and command mode
inoremap <C-a> <c-o>^
inoremap <C-e> <end>
inoremap <C-k> <c-o>D
cnoremap <C-a> <home>
cnoremap <C-e> <end>
cnoremap <C-e> <end>
cnoremap <C-k> <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<cr>
cnoremap <C-b> <left>

" Use Fzf for completions where applicable
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')

" Provide a interactive cheat-sheet for leader mappings with WhichKey
"" Configure general settings
let g:which_key_sep = '→'

"" Configure Normal mode mappings
let g:which_key_map_n =  {}

nnoremap <silent> <space>q :q!<cr>
let g:which_key_map_n.q = 'quit'
let g:which_key_map_n.w = ['w',   'write']
let g:which_key_map_n.x = ['x',   'save/quit']


let g:which_key_map_n.t = {
    \ 'name' : '+toggle',
    \ 'n' : [':set number!', 'line numbers'],
    \ 's' : [':set spell!',  'spell check'],
    \ }

let g:which_key_map_n.e = {
    \ 'name' : '+edit',
    \ 'v' : ['vimrc#edit()', 'vimrc'],
    \ }

let g:which_key_map_n.l = {
    \ 'name' : '+load',
    \ 'v' : ['vimrc#save_and_source()', 'vimrc'],
    \ }

let g:which_key_map_n.s = {
    \ 'name' : '+search',
    \ '/' : [':History/',  'history'],
    \ ';' : [':Commands',  'commands'],
    \ 'b' : [':BLines',    'current buffer'],
    \ 'B' : [':Buffers',   'open buffers'],
    \ 'c' : [':Commits',   'commits'],
    \ 'C' : [':BCommits',  'buffer commits'],
    \ 'f' : [':Files',     'files'],
    \ 'F' : [':Filetypes', 'file types'],
    \ 'g' : [':GFiles',    'git files'],
    \ 'G' : [':GFiles?',   'modified git files'],
    \ 'h' : [':History',   'file history'],
    \ 'H' : [':History:',  'command history'],
    \ 'l' : [':Lines',     'lines'],
    \ 'm' : [':Marks',     'marks'],
    \ 'p' : [':Helptags',  'help tags'],
    \ 's' : [':Snippets',  'snippets'],
    \ 'S' : [':Colors',    'color schemes'],
    \ 't' : [':Rg',        'text Rg'],
    \ 'w' : [':Windows',   'search windows'],
    \ 'z' : [':FZF',       'FZF'],
    \ }

nnoremap <silent> <space>oq  :copen<CR>
nnoremap <silent> <space>ol  :lopen<CR>
let g:which_key_map_n.o = {
      \ 'name' : '+open',
      \ 'q' : 'open-quickfix'    ,
      \ 'l' : 'open-locationlist',
      \ }

let g:which_key_map_n.g = {
    \ 'name' : '+git',
    \ 'b' : [':Git blame',         'blame'],
    \ 's' : [':Git',               'status'],
    \ 'c' : [':Git commit',        'commit'],
    \ 'q' : [':GitGutterQuickFix', 'quickfix'],
    \ 'w' : [':GBrowse',           'browse'],
    \ }

let g:which_key_map_n.n = {
    \ 'name' : '+next' ,
    \ 'b' : [':bnext',             'buffer'],
    \ 'h' : [':GitGutterNextHunk', 'hunk (git)'],
    \ 'q' : [':cnext',             'quickfix'],
    \ }

let g:which_key_map_n.p = {
    \ 'name' : '+previous' ,
    \ 'b' : [':bprevious',         'buffer'],
    \ 'h' : [':GitGutterPrevHunk', 'hunk (git)'],
    \ 'q' : [':cprevious',         'quickfix'],
    \ }

let g:which_key_map_n.r = ["<plug>(coc-rename)", "rename"]

let g:which_key_map_n.c = {
    \ "name": "+coc",
    \ "a": [":CocAction", "action"],
    \ "c": [":CocCommand", "command"],
    \ "d": [":CocDiagnostics", "diagnostics"],
    \ "r": [":CocRestart", "restart"],
    \ "e": [":CocConfig", "edit-config"],
    \ "l": [":CocList", "list"],
    \ "o": [":CocLocalConfig", "edit-local-config"],
    \ "u": [":CocUpdate", "update"],
    \ }

"" Configure Visual mode mappings
let g:which_key_map_v = {}
let g:which_key_map_v.a = [":'<,'>EasyAlign", 'align']
let g:which_key_map_v.y = ['"+y', "copy"]
let g:which_key_map_v.f = ["<plug>(coc-format-selected)", "format"]

"" Register WhichKey mappings
nnoremap <silent> <space> :WhichKey 'Normal'<cr>
vnoremap <silent> <space> :WhichKeyVisual 'Visual'<cr>
autocmd VimEnter * call which_key#register('Normal', 'g:which_key_map_n')
autocmd VimEnter * call which_key#register('Visual', 'g:which_key_map_v')
