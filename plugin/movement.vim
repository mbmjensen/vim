if exists("g:loaded_movement")
    finish
endif
let g:loaded_movement = 1

" Buffers
nnoremap <silent> <Plug>(movement-bnext) :bnext<CR>
    \ :call repeat#set("\<Plug>(movement-bnext)")<CR>
nnoremap <silent> <Plug>(movement-blast) :blast<CR>
    \ :call repeat#set("\<Plug>(movement-blast)")<CR>
nnoremap <silent> <Plug>(movement-bprev) :bprev<CR>
    \ :call repeat#set("\<Plug>(movement-bprev)")<CR>
nnoremap <silent> <Plug>(movement-bfirst) :bfirst<CR>
    \ :call repeat#set("\<Plug>(movement-bfirst)")<CR>

" Quickfix
nnoremap <silent> <Plug>(movement-cnext) :cnext<CR>
    \ :call repeat#set("\<Plug>(movement-cnext)")<CR>
nnoremap <silent> <Plug>(movement-clast) :clast<CR>
    \ :call repeat#set("\<Plug>(movement-clast)")<CR>
nnoremap <silent> <Plug>(movement-cprev) :cprev<CR>
    \ :call repeat#set("\<Plug>(movement-cprev)")<CR>
nnoremap <silent> <Plug>(movement-cfirst) :cfirst<CR>
    \ :call repeat#set("\<Plug>(movement-cfirst)")<CR>

" Location
nnoremap <silent> <Plug>(movement-lnext) :lnext<CR>
    \ :call repeat#set("\<Plug>(movement-lnext)")<CR>
nnoremap <silent> <Plug>(movement-llast) :llast<CR>
    \ :call repeat#set("\<Plug>(movement-llast)")<CR>
nnoremap <silent> <Plug>(movement-lprev) :lprev<CR>
    \ :call repeat#set("\<Plug>(movement-lprev)")<CR>
nnoremap <silent> <Plug>(movement-lfirst) :lfirst<CR>
    \ :call repeat#set("\<Plug>(movement-lfirst)")<CR>

" Tabs
nnoremap <silent> <Plug>(movement-tnext) :tnext<CR>
    \ :call repeat#set("\<Plug>(movement-tnext)")<CR>
nnoremap <silent> <Plug>(movement-tlast) :tlast<CR>
    \ :call repeat#set("\<Plug>(movement-tlast)")<CR>
nnoremap <silent> <Plug>(movement-tprev) :tprev<CR>
    \ :call repeat#set("\<Plug>(movement-tprev)")<CR>
nnoremap <silent> <Plug>(movement-tfirst) :tfirst<CR>
    \ :call repeat#set("\<Plug>(movement-tfirst)")<CR>

" Git Hunks
nnoremap <silent> <Plug>(movement-nhunk) :GitGutterNextHunk<CR>
    \ :call repeat#set("\<Plug>(movement-nhunk)")<CR>
nnoremap <silent> <Plug>(movement-phunk) :GitGutterPrevHunk<CR>
    \ :call repeat#set("\<Plug>(movement-phunk)")<CR>
