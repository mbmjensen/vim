let g:PaperColor_Theme_Options = {
  \    'language': {
  \      'python': {
  \        'highlight_builtins': 1
  \      }
  \    }
  \  }

" Make the background transparent; This is a bit hacky because loading a
" different colorscheme will overwrite this.
hi Normal guibg=NONE ctermbg=NONE
