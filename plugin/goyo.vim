function! s:goyo_enter()
    highlight StatusLineNC guifg=#eeeeee
    highlight StatusLine guifg=#eeeeee
    set nobreakindent
    set showbreak=
    set nocursorline
endfunction

function! s:goyo_leave()
    colorscheme PaperColor
    set breakindent
    set showbreak=...
    set cursorline
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
