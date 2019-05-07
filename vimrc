" Michael Jensen's vimrc
"
" This configuration is only tested and configured on Vim 8.1 and up.

" Check that current VIM instance is compatible
if &compatible || v:version < 801
  finish
endif

let g:mapleader = ' '

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
set background=light    " Default to light background
colorscheme PaperColor  " Default to PaperColor theme
set colorcolumn=80      " Mark the 80th char to suggest max line length
set cursorline          " Show the line where the cursor is
if &term =~ "xterm"     " Make cursor a line on insert mode, but block otherwise
    let &t_SI = "\e[6 q"    
    let &t_EI = "\e[2 q"
endif

" Keep backups in one dir
set backup
set backupdir^=~/.vim/cache/backup
if has('win32') || has('win64')
  set backupdir-=~/.vim/cache/backup
  set backupdir^=~/vimfiles/cache/backup
endif

" Keep swapfiles in one dir
set directory^=~/.vimcache/swap//
if has('win32') || has('win64')
  set directory-=~/.vim/cache/swap//
  set directory^=~/vimfiles/cache/swap//
endif

" Keep undo files, if possible
if has('persistent_undo')
  set undofile
  set undodir^=~/.vim/cache/undo//
  if has('win32') || has('win64')
    set undodir-=~/.vim/cache/undo//
    set undodir^=~/vimfiles/cache/undo//
  endif
endif

"Options for file search gf/:find
set path-=/usr/include  " Put filetype specific settings in filetypes

" Give a prompt instead of rejecting commands such as a risky :write
set confirm

" Use UTF-8 if we can and the env LANG doesn't specify that we shouldn't
if has('multi_byte') && !exists('$LANG') && &encoding ==# 'latin1'
  set encoding=utf-8
endif

" Delete comment leaders when joining lines
set formatoptions+=j

" Don't assume we are editing C
" Set this in filetype
set include=

" Show search matches as we type the pattern
set incsearch

" Don't at two spaces to the end of sentences on a join
set nojoinspaces

" Don't redraw the screen on macros, registers, nor other untyped commands
set lazyredraw

" New windows go below or right of a split
set splitbelow
set splitright
