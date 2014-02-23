" Leader keys
:let mapleader = "-"
:let maplocalleader = "\\"

" Workarounds in absence of Drupal .vimrc working
" See https://drupal.org/node/2195775
:au BufNewFile,BufRead *.install,*.test,*.inc set filetype=php
:au BufNewFile,BufRead *.info set filetype=drini

" Integration with own Drupal vim repository
:let g:drupal_vim_dir = "~/.vimrc.d/drupal_vim"
" Only load Drupal vim on command
noremap <buffer> <leader><F2>d<CR> :source ~/.vimrc.d/drupal_vim/.drupal.vimrc<CR>
