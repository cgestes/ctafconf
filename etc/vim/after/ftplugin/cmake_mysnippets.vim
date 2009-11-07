if !exists('loaded_snippet') || &cp
    finish
endif

Snippet if if(<{cond}>)<CR><{}><CR><BS>else(<{cond}>)<CR><{}><CR><BS>endif(<{cond}>)<CR><{}>

Snippet mess( message(STATUS "<{}")
Snippet mv(   message(STATUS "<{var}>: ${<{var}>}")<CR><{}>
