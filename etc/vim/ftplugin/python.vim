set omnifunc=pythoncomplete#Complete

set path+=/usr/lib/python2.6/,/usr/lib/python2.6/site-packages
set tags+=~/.vim/tags/python/tags


" This was incredibly helpful...
abbreviate <buffer> sefl self
abbreviate <buffer> slef self

" To use quickfix with python programs:
setlocal makeprg=python\ %


" This is quite good for python scripts
setlocal expandtab
setlocal smarttab
setlocal shiftwidth=4

" Remove trailing whitespaces when saving:
autocmd bufwritepre * :%s/\s\+$//e

" When editing .ini files, VIM will most of the
" time load syntax/dosini.vim.
" (Syntax is almost the same as ConfigParser,
" except for comments).
" Thi is a fix in a quick and dirty way:
": syn match dosiniComment "#.*^"
"

" Using imaps.vim

call IMAP ("ifn",  "if __name__ == \"__main__\":\n<++>",            "python")
call IMAP ("s." ,  "self.<++>",                                       "python")
call IMAP ("def",  "def <++>(<++>):\n\t\"\"\"\n<++>\n\"\"\"\n<++>",   "python")
call IMAP ("fim",  "from <++> import <++>",                           "python")

