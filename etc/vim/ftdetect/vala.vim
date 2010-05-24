augroup filetype
   au! BufRead,BufNewFile *.vala setfiletype vala
   au! BufRead,BufNewFile *.vapi setfiletype vala
   au! BufRead,BufNewFile *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
   au! BufRead,BufNewFile *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
augroup end
