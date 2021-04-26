" Enable fzf plugin.
set rtp+=$DEV_DIR/fzf/bin
source $DEV_DIR/fzf/plugin/fzf.vim

" Customize fzf colors to match colorscheme, see
" https://github.com/junegunn/fzf/blob/master/README-VIM.md
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'CursorColumn'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['bg', 'Normal'],
  \ 'bg+':     ['bg', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'gutter':  ['bg', 'CursorColumn'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }
