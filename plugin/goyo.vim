function! s:goyo_enter()
    highlight StatusLineNC guifg=#eeeeee
    highlight StatusLine guifg=#eeeeee
    set nobreakindent
    set showbreak=
    set nocursorline
    set fillchars=eob:\ 
endfunction

function! s:goyo_leave()
    colorscheme PaperColor
    set breakindent
    set showbreak=...
    set cursorline
    set fillchars=vert:│                       " Set the vertical window separating character
    set fillchars+=fold:-                      " Fills the foldtext
    set fillchars+=eob:~                       " Mark empty lines below the end of the buffer
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
