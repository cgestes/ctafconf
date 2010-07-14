function! ctafconf#load_profiles()
  let s:ctafconf_path = expand('$HOME') . "/.config/ctafconf"
  let s:profile_file = s:ctafconf_path . "/user-profile.sh"
  let s:lines = readfile(s:profile_file)
  let s:prof_line = ""
  for line in s:lines
    if line =~ '^var_set ctafconf_profiles'
      let s:prof_line = line
      break
    endif
  endfor
  let s:prof_str = substitute(s:prof_line, "var_set ctafconf_profiles" , "", "")
  let s:prof_str = substitute(s:prof_str, '"', "", "g")
  let s:prof_str = substitute(s:prof_str, "'", "", "g")
  let s:profiles = split(s:prof_str)
  for ct_profile in s:profiles
    let s:profile_path = s:ctafconf_path . "/profile/" . ct_profile . "/vimrc"
    if filereadable(s:profile_path)
      execute "source " . s:profile_path
    else
      continue
    endif
  endfor
endfunction
