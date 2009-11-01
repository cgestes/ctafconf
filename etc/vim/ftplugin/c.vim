"Special configuration for C/C++ files

" /!\ this is *not* the default for many projects
setlocal noexpandtab
setlocal smarttab
setlocal shiftwidth=2


setlocal cindent

" Show trailing whitespaces, and tabs with hideous ^I
"setlocal list listchars=trail:·

" Remove trailing whitespaces when saving:
autocmd bufwritepre * :%s/\s\+$//e

