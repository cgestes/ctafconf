#!/bin/sh
##
## wm.sh
## Login : <ctaf@localhost.localdomain>
## Started on  Tue Apr 25 05:18:25 2006 GESTES Cedric
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

#_trap_kill ()
#{
#  echo killing --$@--
#  exit 0
#}
#trap _trap_kill INT TERM


param=$@

#eval "exec -a grkwm $param"
#read
#exec $param ; #echo "$!" >~/.ctafconf/perso/wm_pid )&
#echo $! >~/.ctafconf/perso/wm_pid
echo "Lanching wm:" $param >>~/.ctafconf/perso/ctafconf.log
eval "$param &" ;
echo "$!" >~/.ctafconf/perso/wm_pid$DISPLAY

sleep 1
echo "waiting for wm:" $param >>~/.ctafconf/perso/ctafconf.log
wait `cat ~/.ctafconf/perso/wm_pid$DISPLAY`
echo "after waited wm:" $param >>~/.ctafconf/perso/ctafconf.log
#kill -- -$pid
