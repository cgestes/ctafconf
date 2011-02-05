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


" Map <leader>I to add an "import" line
" at the top of the file
function! AddMissingImport(module)
  let i = 1
  let last_import = 0
  let lines = getline(1, '.')
  for line in lines
    if line =~ "import"
      let last_import = i
    endif
    if line =~ 'import\s\+' . a:module
      return
    endif
    let i = i + 1
  endfor
  let orig_line = line('.')
  let orig_col  = line('.')
  call cursor(last_import, 1)
  call append('.', "import " . a:module)
  call cursor(orig_line+1, orig_col)
endfunction

command! -nargs=1 AddMissingImport :call AddMissingImport('<args>')

nmap <leader>I :call AddMissingImport('<C-R><C-W>') <CR>

