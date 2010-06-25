function! ctafconf#load_profiles()
python <<EOF
import os
import re
import vim
ctafconf_path = os.path.expanduser("~/.config/ctafconf/")
profile_file = open(os.path.join(ctafconf_path, "user-profile.sh"), "r")
profiles = list()
for line in profile_file.readlines():
  if line.startswith("#"):
    continue
  match = re.search(r"\s*var_set\s+ctafconf_profiles\s+'(.*)", line)
  if match is None:
    continue
  else:
    prof_str = match.groups()[0]
    prof_str = prof_str .strip("'")
    prof_str = prof_str.strip('"')
    profiles = prof_str.split()

profile_file.close()
for profile in profiles:
  profile_path = os.path.join(ctafconf_path, "profile", profile, "vimrc")
  if os.path.exists(profile_path):
    vim.command(":source %s" % profile_path)
EOF
endfunction

