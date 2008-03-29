#!/bin/sh
##
## git.sh
## Login : <ctaf42@localhost.localdomain>
## Started on  Sat Mar 29 14:03:39 2008 Cedric GESTES
## $Id$
##
## Author(s):
##  - Cedric GESTES <dtc@ctaf.com>
##
## Copyright (C) 2008 Cedric GESTES
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
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



#
# create a git repository in the folder blabla-git
#
function gsvn-init()
{
  git svn init svn+ssh://blabla blabla-git
}


#
# checkout from the svn (in branch master)
# param: revision
#
function gsvn-up()
{
  rev=$1
  if [ x$rev = x ] ; then
    git fetch
  else
    git fetch -r $rev
  fi
}


function gsvn-ci()
{
  git svn dcommit
}

function gsvn-branch-new()
{

}

function gsvn-branch-commit()
{

}

