set omnifunc=pythoncomplete#Complete

set path+=/usr/lib/python2.6/,/usr/lib/python2.6/site-packages

" Comment this if omnicomplete gets too slow...
set tags+=~/.vim/tags/python/tags


" This is incredibly helpful...
abbreviate <buffer> sefl self
abbreviate <buffer> slef self

" To use quickfix with python programs:
if executable("pyflakes")
  setlocal makeprg=pyflakes\ %
endif


" Follow PEP8
setlocal expandtab
setlocal smarttab
setlocal shiftwidth=4

" Remove trailing whitespaces when saving:
autocmd bufwritepre * :%s/\s\+$//e

" When editing .ini files, VIM will most of the
" time load syntax/dosini.vim.
" (Syntax is almost the same as ConfigParser,
" except for comments).
" This is a fix in a quick and dirty way:
": syn match dosiniComment "#.*^"
"
