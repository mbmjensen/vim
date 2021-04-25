function! vimrc#edit()
    tabnew $MYVIMRC
    let t:vimrc_is_open = 1
endfunction

function! vimrc#save_and_source()
    if exists("t:vimrc_is_open")
        unlet t:vimrc_is_open
        wq
        source $MYVIMRC
    else
        source $MYVIMRC
    endif
endfunction
