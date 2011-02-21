" Configuration file for tex
"

" Set textwidth:
set textwidth=80

" Disable autoindent:
set noautoindent

"  Useful imaps:

imap <buffer> ... \ldots

imap <buffer> « \og
imap <buffer> » \fg

imap <buffer> € \EUR
imap <buffer>~ $\sim\

imap <buffer> \np \newpage


" Using imaps.vim

call IMAP ("\em" , "\\emph{<++>} <++>" , "tex")


call IMAP ("\s3" , "\\subsubsection{ <++> }\<CR><++>" , "tex")
call IMAP ("\s2" , "\\subsection{ <++> }\<CR><++>" , "tex")
call IMAP ("\s1" , "\\section{ <++> }\<CR><++>" , "tex")

call IMAP ("\p" , "\\paragraph{ <++> }<++>" , "tex")
call IMAP ("\sp" , "\\subparagraph{ <++> } <++>" , "tex")

call IMAP ("\bit", "\\begin{itemize}\<cr>\\item <++>\<cr>\\end{itemize}\<cr><++>", "tex")

call IMAP("\footnote", "\\footnote{ <++> } <++>", "tex")

call IMAP("\item", "\\item <++>", "tex")

call IMAP("\fig", "\\begin{figure}\<cr>\\centering\\includegraphics[<++>]{<++>}\<cr>\\caption{<++>}\<cr>\\label{<++>}\<cr>\\end{figure}", "tex")


