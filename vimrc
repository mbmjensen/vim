" Michael Jensen's vimrc
"
" This configuration is only tested and configured on Vim 8.2 and up.

" Check that current VIM instance is compatible
if &compatible || v:version < 802
  finish
endif

let g:mapleader = " "

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
set termguicolors " Indicate that the terminal supports True Color
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

" Use common shell bindings in insert and command mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-k> <C-o>D
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-e> <End>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-b> <Left>

" Run a shell command and insert in the current line
nnoremap <Leader>c i<C-r>=system('')<Left><Left>

" Save and quit vim
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wqa<CR>

" Edit and load vimrc
nnoremap <leader>ev :call vimrc#edit()<CR>
nnoremap <leader>lv :call vimrc#save_and_source()<CR>
