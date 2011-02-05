""
" Quick function to fix perms of scripts.
"
" Simply try to see if first line matches #!,
" and run `chmod +x' on the file
function! FixSheBang(file)
  for line in readfile(a:file, '', 1)
    if line =~ "#!/"
    call system("chmod +x " . a:file)
    endif
  endfor
endfunction

command! -nargs=1 -complete=file FixSheBang :call FixSheBang('<args>')
