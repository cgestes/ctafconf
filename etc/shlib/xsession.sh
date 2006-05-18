#!/bin/sh
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

fwm=~/.ctafconf/perso/current_wm$DISPLAY
fwmpid=~/.ctafconf/perso/wm_pid$DISPLAY
fwmpidtokill=~/.ctafconf/perso/wm_pid_to_kill$DISPLAY

#declare apparray as an array
declare -a apparray
#number of application
apparray[0]=0

#catch a signal, else termcaps shit
_trap_kill ()
{
  trap "" INT TERM KILL
  ct_log "TRAP KILL --$@--"
}

trap _trap_kill INT TERM KILL

loop_wm()
{
  local running_wm=""
  local wm=""

  rm -rf $fwmpid $fwmpidtokill 2>/dev/null
  echo $ctafconf_wm >$fwm
  ct_log "ENTERING XSESSION LOOP" >>~/.ctafconf/perso/ctafconf.log
  while [ x = x ] ; do
    if ! [ x`cat $fwm` = x$running_wm ]; then
      ct_log "IN THE LOOP: x`cat $fwm` = x$running_wm"
      if [ -f $fwmpid ]; then
        cp $fwmpid $fwmpidtokill
        #fucking kill builtin, use real one
        kill_wm "$running_wm" `cat $fwmpid`
        rm -rf $fwmpid $fwmpidtokill 2>/dev/null
      fi
      #exec_wm $curr_wm&
      running_wm=`cat $fwm`
      running_wm=`extract_wm $running_wm`
      exec_wm $! $running_wm &
      #aterm
    fi
    sleep 1
    echo "LOOP --$wm_pid--" >>~/.ctafconf/perso/ctafconf.log
  done
  echo "EXIT FROM XSESSION LOOP" >>~/.ctafconf/perso/ctafconf.log
}

kill_wm()
{
  local wm=$1
  local pid=$2

  case $wm in
    gnome)
      ct_log "KILL_WM: KILLING GNOME (gnome-session-save)"
      gnome-session-save --kill 2>~/.ctafconf/perso/error.log;;
    xfce4)
      ct_log "KILL_WM: KILLING XFCE4 (xfce4-session-logout)"
      xfce4-session-logout ;;
    "")
      ct_log "KILL_WM: NO WM TO KILL" ;;
    *)
      ct_log "KILL_WM: KILLING ($wm) : ($pid)"
      kill $pid;;
  esac
}

#return the wm to launch
extract_wm()
{
  local wm=$1

  if [ x$wm = xrandom ]; then
    sz=`cat ~/.ctafconf/perso/wmlist | wc -l`
    pos=$(( `date +%s` % $sz + 1 ))
    wm=`cat ~/.ctafconf/perso/wmlist | tail -$pos | head -1`
  fi
  ct_log EXTRACTED WM: $wm
  echo $wm >$fwm
  echo $wm
}

exec_wm ()
{
  local pidpid=$1
  local wm=$2
  local wmfct=""

   #pidpid=$!
  wmfct=`cat ~/.ctafconf/etc/xsession/wmlist | grep "^$wm" | cut -d ! -f 2`
   ~/.ctafconf/etc/xsession/wm.sh $wmfct
  if [ x`cat $fwmpid` != x`cat $fwmpidtokill` ]; then
    echo BYEBYE, SHUTDOWN: $@ >>~/.ctafconf/perso/ctafconf.log
    /bin/kill $pidpid
    exit
  fi
}

exec_app()
{
  echo "STARTING LAUNCHING APPS" >>~/.ctafconf/perso/ctafconf.log
  (
    i=${apparray[0]}

    sleep 1
    ct_log number of application to launch: ${apparray[0]}

    while test $i -ge 1 ; do
      ct_log LAUNCHING APP: "${apparray[$i]}"
      eval ${apparray[$i]} &
      i=$(( $i - 1 ))
    done
  )&
  ct_log APPS LAUNCHED
}



#(((((((EXPORTED FUNCTION)))))))

ct_log()
{
  echo $@ >>~/.ctafconf/perso/ctafconf.log
}

#launch delayed application
#then the wm
launch_wm()
{
  ct_log LAUNCHING WM
  exec_app
  loop_wm
  ct_log BYEBYE, WE SHOULD NOT BE THERE
}

#append one application to the launch list
launch_app()
{
  app="$@"
  i=${apparray[0]}
  i=$(( $i + 1 ))

  apparray[0]=$i
  apparray[$i]="$app"
}

#test if current wm
test_wm ()
{
  local wm=$@
  local ret=0

  ct_log -n "test_wm $@ = "
  [ x$ctafconf_wm = x$wm ]
  ret=$?
  ct_log $ret
  return $ret
}
