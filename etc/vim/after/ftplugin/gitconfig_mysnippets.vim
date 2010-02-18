if !exists('loaded_snippet') || &cp
    finish
endif

Snippet [br [branch "<{branch}>"]<CR><TAB>remote = origin<CR>merge = refs/heads/<{branch}>
