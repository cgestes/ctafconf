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

#declare apparray as an array
declare -a apparray
#number of application
apparray[0]=0

#launch delayed application
#then the wm
launch_wm ()
{
  (
    i=1

    sleep 1
    echo number of application to launch: ${apparray[0]}

    while test $i -le ${apparray[0]} ; do
      echo LAUNCHING APP: ${apparray[$i]}
      ${apparray[$i]} &
      i=$(( $i + 1 ))
    done
  )&
  exec $@
}

#append one application to the launch list
launch_app ()
{
  app=$@
  i=${apparray[0]}
  i=$(( $i + 1 ))

  apparray[0]=$i
  apparray[$i]=$app
}

#test if current wm
test_wm ()
{
  wm=$@

  test x$ctafconf_wm = x$wm
  return $?
}
