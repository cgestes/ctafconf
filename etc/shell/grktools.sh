#!/bin/sh
##
## grkinstall.sh
## Login : <ctaf@localhost.localdomain>
## Started on  Tue Apr 11 12:53:25 2006 GESTES Cedric
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

grk_backup=~/.ctafconf/perso/previous
grk_etc=~/.ctafconf
grk_debug=yes

#0 good
#1 bad
grk_testlink ()
{
  local src=$1
  local dst=$2

  [ x$grk_debug = xyes ] && echo "Testing link: $grk_etc/$src $dst"
  if ! which file >/dev/null 2>/dev/null || ! [ "x`file -b $dst`" = "xsymbolic link to \`$grk_etc/$src'" ] ; then
      return 1
  fi
  return 0
}

#use diff
#0 good
#1 bad
grk_testfile()
{
  local src=$1
  local dst=$2

  [ x$grk_debug = xyes ] && echo "Testing file: $grk_etc/$src $dst"
  if ! [ -f $dst ] || [ -h $dst ] ; then
      return 1
  fi
  return 0
}

#0 good
#1 bad
grk_testdir()
{
#  local src=$1
  local dst=$1

  [ x$grk_debug = xyes ] && echo "Testing dir: $src $dst"
  if ! [ -d $dst ]; then
      return 1
  fi
  return 0
}

#create a link
#grk_link src dst name
#if name is speficied a backup is created
grk_link ()
{
  local src=$1
  local dst=$2
  local name=$3

  if  ! which file >/dev/null 2>/dev/null ||
      ! [ "x`file -b $dst`" = "xsymbolic link to \`$grk_etc/$src'" ] ; then
      if ! [ x$name = x ]; then
          [ x$grk_debug = xyes ] && echo "grk_link: Backup $name"
          rm -rf  $grk_backup/"$name"-previous 2>/dev/null
          cp $dst $grk_backup/"$name"-previous 2>/dev/null
          mv $dst $grk_backup/"$name"-prev-"$date" 2>/dev/null
      fi
      [ x$grk_debug = xyes ] && echo "Linking: $dst -> $src"
      ln -s $grk_etc/$src $dst
  fi
}

grk_sudofile ()
{
  local src=$1
  local dst=$2
  local name=$3

  #not a symlink, same file
  if ! [ -h $dst ] && diff $dst $grk_etc/$src >/dev/null 2>/dev/null; then
      return
  fi
  if [ -f $dst ]; then
      if ! [ x$name = x ]; then
          [ x$grk_debug = xyes ] && echo "grk_sudofile: Backup $name"
          $ctafconf_sudo rm -rf  $grk_backup/$name-previous 2>/dev/null
          $ctafconf_sudo cp $dst $grk_backup/$name-previous 2>/dev/null
          $ctafconf_sudo mv $dst $grk_backup/$name-prev-$date 2>/dev/null
      fi
  fi
  #remove symlink
  if [ -h $dst ]; then
      $ctafconf_sudo rm -rf $dst 2>/dev/null
  fi
  [ x$grk_debug = xyes ] && echo "Sudo Copying: $src in $dst"
  $ctafconf_sudo cp $grk_etc/$src $dst 2>/dev/null
}

#install .mine
grk_file ()
{
  local src=$1
  local dst=$2
  local name=$3

  #not a symlink, same file
  if ! [ -h $dst ] && diff $dst $grk_etc/$src >/dev/null 2>/dev/null; then
      return
  fi
  if [ -f $dst ]; then
      if ! [ x$name = x ]; then
          [ x$grk_debug = xyes ] && echo "grk_file: Backup $name"
          rm -rf      $grk_backup/"$name"-previous 2>/dev/null
          cp -r $dst $grk_backup/"$name"-previous 2>/dev/null
          mv    $dst $grk_backup/"$name"-prev-"$date" 2>/dev/null
      fi
  fi
  #remove symlink
  if [ -h $dst ]; then
      rm -rf $dst 2>/dev/null
  fi
  [ x$grk_debug = xyes ] && echo "Copying: $src in $dst"
  cp $grk_etc/$src $dst
}

#create a dir if it doesnt exist
#backup the dir if name is speficied
grk_dir ()
{
  local dst=$1
  local name=$2

  if ! [ -d $dst ]; then
      if ! [ x$name = x ]; then
          [ x$grk_debug = xyes ] && echo "grk_dir: Backup $name"
          rm -rf $grk_backup/"$name"-previous 2>/dev/null
          cp -r $dst $grk_backup/"$name"-previous 2>/dev/null
          mv $dst ~/.ctafconf/perso/previous/"$name"-prev-"$date" 2>/dev/null
      fi
  fi
  [ x$grk_debug = xyes ] && echo "Creating directory: $src"
  mkdir $dst 2>/dev/null
}

grk_mine ()
{
  src=$1
  name=$2

  echo "mine: $src -- $name"
}
