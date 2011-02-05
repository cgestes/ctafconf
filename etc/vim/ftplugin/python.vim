set omnifunc=pythoncomplete#Complete


let s:py_version = system("python --version")
let s:py_version = strpart(s:py_version, 7) " Remove 'Python '
let s:py_version = strpart(s:py_version, 0, 3) " Keep only the major version

let s:py_path="/usr/lib/python" . s:py_version .
    \ "," . "/usr/lib/python" . s:py_version . "/site-packages"

let &path=&path . "," . s:py_path

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

"Man K to call Pydoc
noremap K  :call ShowPyDoc('<C-R><C-W>', 1)<CR>
