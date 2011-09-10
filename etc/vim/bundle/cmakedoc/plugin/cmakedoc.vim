" cmakedoc.vim
" Print cmake documentation for the command behind the cursor
" Assumes cmake is in PATH
" (Based on code from pydoc.vim)

set switchbuf=useopen
function! ShowCMakeDoc(name)
	if bufnr("__doc__") >0
			exe "sb __doc__"
	else
			exe 'split __doc__'
	endif
	setlocal noswapfile
	set buftype=nofile
	setlocal modifiable
	normal ggdG
    execute  "silent read ! ". "cmake --help-command " . a:name
	setlocal nomodified
	set filetype=txt
	normal 1G
endfunction

command! -nargs=1 ShowCMakeDoc :call ShowCMakeDoc('<args>')
