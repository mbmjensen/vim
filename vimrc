if &compatible || v:version < 802          " Exit if below minimum version this config has been tested on
  finish
endif

filetype plugin indent on                  " Load filetype settings, plugins, and maps
syntax enable                              " Enable syntax highlighting

                                           " Set default indent settings (customize by filetype in vim/indent/ or vim/after/indent/)
set autoindent                             " Use indent of previous line on new lines
set expandtab                              " Use spaces instead of tabs
set shiftwidth=4                           " Indent with 4 spaces
set softtabstop=4                          " Insert 4 spaces with the tab key

set backspace+=eol                         " Enable backspace to work over line breaks
set backspace+=indent                      " Spaces from 'autoindent'
set backspace+=start                       " The start of the current insertion

                                           " Wrap options
silent! set breakindent                    " Indent wrapped lines
set showbreak=...                          " Prefix wrapped rows with 3 dots
set linebreak                              " Wrap lines at word boundaries

                                           " Extra 'list' display character options
set list                                   " Turn on list characters by default
set listchars=                             " Clear the default listchars
set listchars+=tab:»\                      " Tab characters, preserve width
set listchars+=extends:›                   " Unwrapped text to screen right
set listchars+=precedes:‹                  " Unwrapped text to screen left
set listchars+=trail:•                     " Trailing spaces
set listchars+=nbsp:•                      " Non-breaking spaces

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " Fix true color support for tmux, see
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " https://github.com/tmux/tmux/issues/1246#issue-292083184
    set termguicolors                      " Indicate that the terminal supports True Color
endif

set fillchars=vert:│                       " Set the vertical window separating character
set fillchars+=fold:-                      " Fills the foldtext
set fillchars+=eob:~                       " Mark empty lines below the end of the buffer

set background=light                       " Default to light background
colorscheme PaperColor                     " Default to PaperColor theme
set cursorline                             " Show the line where the cursor is
set colorcolumn=89                         " Mark the 89th char to suggest max line length at 88

if &term =~ 'xterm' || &term =~ 'screen'
    let &t_SI = "\<Esc>[6 q"               " Make cursor a line on insert mode but block otherwise
    let &t_EI = "\<Esc>[2 q"               " Make cursor a block when leaving insert mode
endif
                                           " Sets the cursor to a block by entering and exiting insert mode when
if has('autocmd')                          " entering vim. Hacky but more effective than other ways I've tried
    autocmd VimEnter * silent normal i
endif

set viminfo+=n~/.vim/.viminfo              " Move the viminfo into the vim directory (n denotes name of viminfo file)

set directory^=~/.vim/cache/swap           " Keep swapfiles in one dir

if has('persistent_undo')                  " Keep undo files, if possible
    set undofile
    set undodir^=~/.vim/cache/undo
endif

set path=                                  " Set directories to search when using gf, :find, etc
set path+=.                                " Search relative to the current file
set path+=,,                               " Search in the current directory

set include=                               " Remove the C specific default setting

set confirm                                " Prompt instead of rejecting commands such as a risky :write

if has('multi_byte')                       " Use UTF-8 if possible
  set encoding=utf-8
endif

set formatoptions+=j                       " Remove comment leader when joining lines
set nojoinspaces                           " Don't add two spaces to the end of sentences on a join

set incsearch                              " Show the search pattern while typing
set ignorecase                             " Make the search case-insensitive by default
set smartcase                              " Unless an uppercase character is in the pattern

set lazyredraw                             " Don't redraw the screen on macros, registers, nor other untyped commands

set splitbelow                             " New windows go below
set splitright                             " And right of a split

set ttimeoutlen=100                        " Set the delay for key code sequences, not mappings (default: timeoutlen)

                                           " Create sensible ways to search search and command history
nnoremap <silent> q/ :History/<CR>
nnoremap <silent> q: :History:<CR>
                                           " Hook fzf into ins-completion (i_Ctrl-x)
imap <C-x><C-l> <Plug>(fzf-complete-line)
inoremap <expr> <C-x><C-f> fzf#vim#complete#path('fd')

                                           " Use common readline shortcuts in insert and command mode
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
inoremap <C-k> <C-o>D
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-b> <Left>

                                           " Provide a interactive cheat-sheet for leader mappings with WhichKey
let g:which_key_sep = '→'                  " Use arrow to separate keys and descriptions

                                           " Use s for [s]earch instead of [s]ubstitute
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
                                           " Configure Normal mode mappings
let g:which_key_map_n = {}
let g:which_key_map_n.q = [':quit',  'quit']
let g:which_key_map_n.w = [':write', 'write']
let g:which_key_map_n.x = [':xit',   'xit']

let g:which_key_map_n.t = {
    \ 'name': '+toggle',
    \ 'g': [':GitGutterSignsToggle',  'git gutter'],
    \ 'n': [':set number!', 'line numbers'],
    \ 's': [':set spell!',  'spell check'],
    \ 'w': [':set wrap!', 'line wrap'],
    \ }

let g:which_key_map_n.l = {
    \ 'name': '+load',
    \ 'v': [':call vimrc#save_and_source()', 'vimrc'],
    \ }

let g:which_key_map_n.o = {
    \ 'name': '+open',
    \ 'f': [':!open %',                          'current-file'],
    \ 'l': [':lopen',                            'location-list'],
    \ 's': [':CocCommand snippets.editSnippets', 'snippet-current-ft'],
    \ 'q': [':copen',                            'quickfix'],
    \ 't': [':terminal',                         'terminal'],
    \ 'v': [':call vimrc#edit()',                'vimrc'],
    \ }

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
    \ 'r': [':call feedkeys(":Git reset ")',         'reset'],
    \ 'S': [':Git | only',                           'fullscreen-summary'],
    \ 's': [':Git',                                  'summary'],
    \ 'v': [':call feedkeys(":Git branch ")',        'branch'],
    \ 'w': [':GBrowse',                              'browse'],
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
let g:which_key_map_n.R = [':call feedkeys("*#:%s///g\<Left>\<Left>")', 'replace-no-confirm']

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

                                           " Configure Visual mode mappings
let g:which_key_map_v = {
    \ 'a': [":'<,'>EasyAlign",             'align'],
    \ 'c': [":'<,'>CocAction",             'coc-action'],
    \ 'f': ['<Plug>(coc-format-selected)', 'format'],
    \ 's': ['<Plug>(coc-snippets-select)', 'snippet-visual'],
    \ 'y': [":'<,'>y +",                   'clip'],
    \ }

vnoremap <silent> <Space> :WhichKeyVisual 'Visual'<CR>
autocmd VimEnter * call which_key#register('Visual', 'g:which_key_map_v')
