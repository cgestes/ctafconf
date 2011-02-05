"cmakedoc.vim
"Print cmake documentation for the command behind the cursor
"Assumes cmake is in PATH



"pydoc.vim is free software, you can redistribute or modify
"it under the terms of the GNU General Public License Version 2 or any
"later Version (see http://www.gnu.org/copyleft/gpl.html for details).


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

"commands
command! -nargs=1 ShowCMakeDoc :call ShowCMakeDoc('<args>')


" file(
