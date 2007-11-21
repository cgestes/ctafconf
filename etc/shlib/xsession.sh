#!/usr/bin/env bash
##
## xsession.sh
## Login : <ctaf@localhost.localdomain>
## Started on  Thu Apr 20 22:14:06 2006 GESTES Cedric
## $Id$
##
## Copyright (C) 2006 GESTES Cedric
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##

#fwm=~/.config/ctafconf/perso/current_wm$DISPLAY
#fwmpid=~/.config/ctafconf/perso/wm_pid$DISPLAY
#fwmpidtokill=~/.config/ctafconf/perso/wm_pid_to_kill$DISPLAY


#declare apparray as an array
#declare -a apparray
#number of application
app_array_count=0



#return the wm to launch
extract_wm()
{
  local wm=$1

  ct_log EXTRACTING WM: $wm
  if [ x$wm = xrandom ]; then
    sz=`cat ~/.config/ctafconf/perso/wmlist | wc -l`
    pos=$(( `date +%s` % $sz + 1 ))
    wm=`cat ~/.config/ctafconf/perso/wmlist | tail -$pos | head -1`
  fi
  ct_log EXTRACTED WM: $wm
  echo $wm
}

exec_wm ()
{
  local wm=$1
  local wmfct=""

  wmfct=`cat ~/.config/ctafconf/etc/xsession/wmlist | grep "^$wm" | cut -d ! -f 2`
  echo "lanching: $wmfct"
  which $wmfct && exec $wmfct

}

exec_app()
{
  echo "STARTING LAUNCHING APPS" >>~/.config/ctafconf/perso/ctafconf.log
  (
    local i=1
    local cmd=''

    sleep 1
    ct_log number of application to launch: $i

    while test $i -le $app_array_count ; do
      ct_log LAUNCHING APP: $(eval echo "$"apparray_$i)
      cmd=$(eval echo "$"apparray_$i)
      eval $cmd &
      i=$(( $i + 1 ))
    done
  )&
  ct_log APPS LAUNCHED
}

#(((((((EXPORTED FUNCTION)))))))

ct_log()
{
  echo $@ >>~/.config/ctafconf/perso/ctafconf.log
}

#launch delayed application
#then the wm
launch_wm()
{
  ct_log LAUNCHING WM
  exec_app
#  loop_wm
  ctafconf_wm=`extract_wm $ctafconf_wm`
  ct_log launching: $ctafconf_wm
  exec_wm $ctafconf_wm
  ct_log BYEBYE, WE SHOULD NOT BE THERE
}

#append one application to the launch list
launch_app()
{
  app="$@"
  app_array_count=$(( $app_array_count + 1 ))
  eval "apparray_$app_array_count='$app'"
}

#test if current wm
test_wm ()
{
  local wm=$@
  local ret=0

  ctafconf_wm=`extract_wm $ctafconf_wm`
  ct_log -n "test_wm ($ctafconf_wm = $@) => "
  [ x$ctafconf_wm = x$wm ]
  ret=$?
  ct_log $ret
  return $ret
}
