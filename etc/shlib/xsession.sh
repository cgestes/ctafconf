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
#  trap "" INT TERM KILL
  echo "killing --$@--" >>~/.ctafconf/perso/ctafconf.log
}

trap _trap_kill INT TERM KILL

loop_wm()
{
  local curr_wm=$ctafconf_wm

  echo $ctafconf_wm >$fwm
  echo "ENTERING XSESSION LOOP" >>~/.ctafconf/perso/ctafconf.log

  while [ x = x ] ; do
    if ! [ x`cat $fwm` = x$curr_wm ]; then
      echo "IN DA LOOP" >>~/.ctafconf/perso/ctafconf.log
      curr_wm=`cat $fwm`
      cp $fwmpid $fwmpidtokill
      #fucking kill builtin, use real one
      /bin/kill -- `cat $fwmpid`
      exec_wm $curr_wm&
      #aterm
    fi
    sleep 1
    echo "LOOP --$wm_pid--" >>~/.ctafconf/perso/ctafconf.log
  done
  echo "EXIT FROM XSESSION LOOP" >>~/.ctafconf/perso/ctafconf.log
}

exec_wm ()
{
  local wm=$1
  local wmfct

   pidpid=$!
   if [ x$wm = xrandom ]; then
     sz=`cat ~/.ctafconf/perso/wmlist | wc -l`
     pos=$(( `date +%s` % $sz + 1 ))
     wm=`cat ~/.ctafconf/perso/wmlist | tail -$pos | head -1`
   fi
   wmfct=`cat ~/.ctafconf/etc/xsession/wmlist | grep "^$wm" | cut -d ! -f 2`

   ~/.ctafconf/etc/xsession/wm.sh $wmfct
  if [ x`cat $fwmpid` != x`cat $fwmpidtokill` ]; then
    echo BYEBYE, SHUTDOWN: $@ >>~/.ctafconf/perso/ctafconf.log
    kill $pidpid
    exit
  fi
}

exec_app()
{
  echo "STARTING LAUNCHING APPS" >>~/.ctafconf/perso/ctafconf.log
  (
    i=${apparray[0]}

    sleep 1
    echo number of application to launch: ${apparray[0]}

    while test $i -ge 1 ; do
      echo LAUNCHING APP: "${apparray[$i]}" >>~/.ctafconf/perso/ctafconf.log
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
  exec_wm $ctafconf_wm &
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
