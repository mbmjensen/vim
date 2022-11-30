if &compatible || v:version < 802
  finish
endif

" {{{ General

filetype plugin indent on                  " Load filetype settings, plugins, and maps
syntax enable                              " Enable syntax highlighting

if has('multi_byte')                       " Use UTF-8 if possible
  set encoding=utf-8
endif

set splitbelow                             " New windows go below
set splitright                             " and right of a split

set ttimeoutlen=100                        " Set the delay for key code sequences,
                                           " not mappings (default: timeoutlen)

set lazyredraw                             " Don't redraw the screen on macros,
                                           " registers, nor other untyped commands
" }}}
" {{{ Indent

" Set custom filetype indent settings in ~/.vim/indent and ~/.vim/after/indent
set autoindent                             " Use indent of previous line on new lines
set expandtab                              " Use spaces instead of tabs
set shiftwidth=4                           " Indent with 4 spaces
set softtabstop=4                          " Insert 4 spaces with the tab key

" }}}
" {{{ Line
" {{{ Backspacing

set backspace+=eol                         " Enable backspace to work over line breaks
set backspace+=indent                      " Spaces from 'autoindent'
set backspace+=start                       " The start of the current insertion

" }}}
" {{{ Wrapping

set breakindent                            " Indent wrapped lines
set showbreak=...                          " Prefix wrapped rows with 3 dots
set linebreak                              " Wrap lines at word boundaries

set formatoptions+=j                       " Remove comment leader when joining lines
set nojoinspaces                           " Don't add two spaces to the end of sentences on a join

" }}}
" }}}
" {{{ Appearance
" {{{ Colorscheme

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Fix true color support for tmux, see
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " https://github.com/tmux/tmux/issues/1246#issue-292083184
    set termguicolors
endif

set background=light

try                                         " Default to desert if PaperColor
    colorscheme PaperColor                  " doesn't exist
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

set cursorline
set colorcolumn=89

" }}}
" {{{ List and Fill Characters

set list                                   " Turn on list characters by default
set listchars=                             " Clear the default listchars
set listchars+=tab:»\                      " Tab characters, preserve width
set listchars+=extends:›                   " Unwrapped text to screen right
set listchars+=precedes:‹                  " Unwrapped text to screen left
set listchars+=trail:•                     " Trailing spaces
set listchars+=nbsp:•                      " Non-breaking spaces

set fillchars=vert:│                       " Set the vertical window separating character
set fillchars+=fold:-                      " Fills the foldtext
set fillchars+=eob:~                       " Mark empty lines below the end of the buffer

" }}}
" }}}
" {{{ Cursor
if &term =~ 'xterm' || &term =~ 'screen'
    let &t_SI = "\<Esc>[6 q"               " Make cursor a line on insert mode
    let &t_EI = "\<Esc>[2 q"               " Make cursor a block when leaving insert mode
endif
                                           " Sets the cursor to a block when entering vim
if has('autocmd')
    autocmd VimEnter * silent normal i
endif
" }}}
" {{{ Caching
if !isdirectory(expand('~/.vim/cache'))
    eval system('mkdir ' . expand('~/.vim/cache'))
    eval system('mkdir ' . expand('~/.vim/cache/swap'))
    eval system('mkdir ' . expand('~/.vim/cache/undo'))
endif

set viminfo+=n~/.vim/cache/.viminfo
set directory^=~/.vim/cache/swap
let g:netrw_home = '~/.vim/cache'

if has('persistent_undo')
    set undofile
    set undodir^=~/.vim/cache/undo
endif
" }}}
" {{{ Path
set path=       " Set directories to search when using gf, :find, etc
set path+=.     " Search relative to the current file
set path+=,,    " Search in the current directory

set include=    " Remove the C specific default setting

set confirm     " Prompt instead of rejecting commands such as a risky :write
" }}}
" {{{ Search
set incsearch                              " Show the search pattern while typing
set ignorecase                             " Make the search case-insensitive by default
set smartcase                              " Unless an uppercase character is in the pattern
" }}}
" {{{ FZF
                                           " Create sensible ways to search and command history
if executable('fzf') && isdirectory(expand('~/.vim/pack/submodules/start/fzf.vim'))
    nnoremap <silent> q/ :History/<CR>
    nnoremap <silent> q: :History:<CR>
                                               " Hook fzf into ins-completion (i_Ctrl-x)
    imap <C-x><C-l> <Plug>(fzf-complete-line)
    inoremap <expr> <C-x><C-f> fzf#vim#complete#path('fd')
endif
" }}}
" {{{ Mappings
" {{{ Readline
" Use common readline shortcuts in insert and command mode
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
inoremap <C-k> <C-o>D
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-b> <Left>
" }}}
" {{{ Copy Paste
nmap cy <Plug>SystemCopy
xmap cy <Plug>SystemCopy
nmap cp <Plug>SystemPaste
" }}}
" {{{ WhichKey
" {{{ Settings
" Provide a interactive cheat-sheet for leader mappings with WhichKey
let g:which_key_sep = '→'
" }}}
" {{{ Search
" Use s for [s]earch instead of [s]ubstitute
if executable('fzf') && isdirectory(expand('~/.vim/pack/submodules/start/fzf.vim'))
    nnoremap s <Nop>
    let g:which_key_map_s =  {
        \ ';': [':Commands',              'commands'],
        \ 'b': [':Buffers',               'buffers'],
        \ 'C': [':BCommits',              'buffer-commits'],
        \ 'c': [':Commits',               'commits'],
        \ 'd': [':GFiles?',               'dirty-git'],
        \ 'f': [':Files',                 'files'],
        \ 'g': [':GFiles',                'git-files'],
        \ 'h': [':Helptags',              'help'],
        \ 'j': [':Marks',                 'marks'],
        \ 'L': [':BLines',                'buffer-lines'],
        \ 'l': [':Lines',                 'lines'],
        \ 'm': [':Maps',                  'maps'],
        \ 'r': [':call feedkeys(":Rg ")', 'Rg'],
        \ 's': [':Snippets',              'snippets'],
        \ 't': [':Filetypes',             'filetype'],
        \ 'w': [':Windows',               'windows'],
        \ }
    nnoremap <silent> s :WhichKey 'Search'<CR>
    autocmd VimEnter * call which_key#register('Search', 'g:which_key_map_s')
endif
" }}}
" {{{ Normal Mode
let g:which_key_map_n = {}
let g:which_key_map_n.q = [':quit',  'quit']
let g:which_key_map_n.w = [':write', 'write']
let g:which_key_map_n.x = [':xit',   'xit']

let g:which_key_map_n.t = {
    \ 'name': '+toggle',
    \ 'c': [':Colors',               'colorscheme'],
    \ 'h': [':colorscheme hubble',   'hubble'],
    \ 'g': [':GitGutterSignsToggle', 'git gutter'],
    \ 'n': [':set number!',          'line numbers'],
    \ 's': [':set spell!',           'spell check'],
    \ 'w': [':set wrap!',            'line wrap'],
    \ }

let g:which_key_map_n.l = {
    \ 'name': '+load',
    \ 'v': [':call vimrc#save_and_source()', 'vimrc'],
    \ }

let g:which_key_map_n.o = {
    \ 'name': '+open',
    \ 'f': [':!open %',                          'current-file'],
    \ 'g': [':Goyo 80',                          'goyo'],
    \ 'l': [':lopen',                            'location-list'],
    \ 's': [':CocCommand snippets.editSnippets', 'snippet-current-ft'],
    \ 'q': [':copen',                            'quickfix'],
    \ 't': [':terminal',                         'terminal'],
    \ 'v': [':call vimrc#edit()',                'vimrc'],
    \ }

let g:which_key_map_n.s = [':call SynGroup()', 'syntax-group']

let g:which_key_map_n.g = {
    \ 'name': '+git',
    \ 'b': [':Git blame',                            'blame'],
    \ 'c': [':call feedkeys(":Git clone ")',         'clone'],
    \ 'D': [':call feedkeys(":Git difftool HEAD~")', 'diff HEAD~N'],
    \ 'd': [':Git difftool',                         'diff HEAD~1'],
    \ 'f': [':Git fetch',                            'fetch'],
    \ 'l': [':Git log',                              'log'],
    \ 'm': [':call feedkeys(":Git merge ")',         'merge'],
    \ 'o': [':call feedkeys(":Git checkout ")',      'checkout'],
    \ 'p': [':Git pull',                             'pull'],
    \ 'P': [':call feedkeys(":Git push")',           'push'],
    \ 'r': [':Glcd',                                 'change-window-directory'],
    \ 'R': [':call feedkeys(":Git reset ")',         'reset'],
    \ 'S': [':Git | only',                           'fullscreen-summary'],
    \ 's': [':Git',                                  'summary'],
    \ 'v': [':call feedkeys(":Git branch ")',        'branch'],
    \ 'w': [':GBrowse',                              'browse'],
    \ 'W': [":GBrowse!",                             'git-browse-clipboard'],
    \ 'y': [':call feedkeys(":Git switch ")',        'switch'],
    \ }

let g:which_key_map_n.n = {
    \ 'name': '+next' ,
    \ 'B': ['<Plug>(movement-blast)', 'last-buffer'],
    \ 'b': ['<Plug>(movement-bnext)', 'buffer'],
    \ 'h': ['<Plug>(movement-nhunk)', 'hunk-git'],
    \ 'L': ['<Plug>(movement-llast)', 'last-locationlist'],
    \ 'l': ['<Plug>(movement-lnext)', 'locationlist'],
    \ 'Q': ['<Plug>(movement-clast)', 'last-quickfix'],
    \ 'q': ['<Plug>(movement-cnext)', 'quickfix'],
    \ }

let g:which_key_map_n.p = {
    \ 'name': '+previous' ,
    \ 'B': ['<Plug>(movement-bFirst)', 'first-buffer'],
    \ 'b': ['<Plug>(movement-bprev)',  'buffer'],
    \ 'h': ['<Plug>(movement-phunk)',  'hunk-git'],
    \ 'L': ['<Plug>(movement-lfirst)', 'first-locationlist'],
    \ 'l': ['<Plug>(movement-lprev)',  'locationlist'],
    \ 'Q': ['<Plug>(movement-cfirst)', 'first-quickfix'],
    \ 'q': ['<Plug>(movement-cprev)',  'quickfix'],
    \ }

let g:which_key_map_n.r = [':call feedkeys("*#:%s///gc\<Left>\<Left>\<Left>")', 'replace']
let g:which_key_map_n.R = [':call feedkeys("*#:%s///g\<Left>\<Left>")',         'replace-no-confirm']

let g:which_key_map_n.c = {
    \ 'name': '+coc',
    \ 'a': [':CocAction',      'action'],
    \ 'c': [':CocCommand',     'command'],
    \ 'd': [':CocDiagnostics', 'diagnostics'],
    \ 'e': [':CocConfig',      'edit-config'],
    \ 'l': [':CocList',        'list'],
    \ 'o': [':CocLocalConfig', 'edit-local-config'],
    \ 'r': [':CocRestart',     'restart'],
    \ 'u': [':CocUpdate',      'update'],
    \ }

autocmd VimEnter * call which_key#register('Normal', 'g:which_key_map_n')
nnoremap <silent> <Space> :WhichKey 'Normal'<CR>
" }}}
" {{{ Visual
let g:which_key_map_v = {
    \ 'a': [":'<,'>EasyAlign",             'align'],
    \ 'c': [":'<,'>CocAction",             'coc-action'],
    \ 'f': ['<Plug>(coc-format-selected)', 'format'],
    \ 's': ['<Plug>(coc-snippets-select)', 'snippet-visual'],
    \ 'w': [":'<,'>GBrowse",               'git-browse'],
    \ 'W': [":'<,'>GBrowse!",              'git-browse-clipboard'],
    \ 'y': [":'<,'>y +",                   'clip'],
    \ }

vnoremap <silent> <Space> :WhichKeyVisual 'Visual'<CR>
autocmd VimEnter * call which_key#register('Visual', 'g:which_key_map_v')
" }}}
" }}}
" }}}
" vim: ft=vim fdm=marker
