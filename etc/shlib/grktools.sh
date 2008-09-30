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

grk_backup=~/.config/ctafconf/perso/previous
grk_etc=~/.config/ctafconf
grk_minedir=~/.config/ctafconf/perso
grk_debug=no

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
  if ! [ -f "$dst" ] || [ -h "$dst" ] ; then
      return 1
  fi
  if diff "$grk_etc/$src" "$dst" >/dev/null; then
    return 0
  fi
  return 1
}

#0 good
#1 bad
grk_testdir()
{
#  local src=$1
  local dst=$1

  [ x$grk_debug = xyes ] && echo "Testing dir: $src $dst"
  if ! [ -d "$dst" ]; then
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
      rm -rf "$dst" 2>/dev/null
      ln -s "$grk_etc/$src" "$dst"
  fi
}

grk_sudofile ()
{
# code disable one day but..
# echo "Warning grk_sudofile not implemented"
# sometimes later..
# r289: reloaded from death "like it was"
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
  if ! [ -h "$dst" ] && diff "$dst" "$grk_etc/$src" >/dev/null 2>/dev/null; then
      return
  fi
  if [ -f "$dst" ]; then
      if ! [ "x$name" = x ]; then
          [ x$grk_debug = xyes ] && echo "grk_file: Backup $name"
          rm -rf      "$grk_backup"/"$name"-previous 2>/dev/null
          cp -r "$dst" "$grk_backup"/"$name"-previous 2>/dev/null
          mv    "$dst" "$grk_backup"/"$name"-prev-"$date" 2>/dev/null
      fi
  fi
  #remove symlink
  if [ -h "$dst" ]; then
      rm -rf "$dst" 2>/dev/null
  fi
  [ x$grk_debug = xyes ] && echo "Copying: $src in $dst"
  cp "$grk_etc/$src" "$dst"
}

#create a dir if it doesnt exist
#backup the dir if name is speficied
grk_dir ()
{
  local dst=$1
  local name=$2

  if ! [ -d "$dst" ]; then
      if ! [ "x$name" = x ]; then
          [ x$grk_debug = xyes ] && echo "grk_dir: Backup $name"
          rm -rf "$grk_backup"/"$name"-previous 2>/dev/null
          cp -r "$dst" "$grk_backup"/"$name"-previous 2>/dev/null
          mv "$dst" ~/.config/ctafconf/perso/previous/"$name"-prev-"$date" 2>/dev/null
      fi
  fi
  [ x$grk_debug = xyes ] && echo "Creating directory: $src"
  mkdir "$dst" 2>/dev/null
}

grk_mine ()
{
  src=$1
  name=$2

  [ x$grk_debug = xyes ] && echo "mine: $src -- $name"
  if ! [ -f ~/.config/ctafconf/perso/"$src".mine ]; then
    cp ~/.config/ctafconf/etc/mine/$src.mine ~/.config/ctafconf/perso
    cp ~/.config/ctafconf/etc/mine/$src.mine ~/.config/ctafconf/perso/previous
    return
  fi

  #same file
  if diff -u ~/.config/ctafconf/etc/mine/"$src".mine ~/.config/ctafconf/perso/"$src".mine 2>/dev/null >/dev/null ; then
    return
  fi

  #user have not modified the file
  if diff -u ~/.config/ctafconf/perso/previous/"$src".mine ~/.config/ctafconf/perso/"$src".mine 2>/dev/null >/dev/null; then
    cp ~/.config/ctafconf/etc/mine/"$src".mine ~/.config/ctafconf/perso/"$src".mine
    return
  fi

#   tmp_patch=~/.config/ctafconf/perso/.tmp1
#   tmp_f1=~/.config/ctafconf/perso/.tmp2
#   tmp_f2=~/.config/ctafconf/perso/.tmp3
#   tmp_diff=~/.config/ctafconf/perso/.tmp4

#   #dest file
#   if [ -f ~/.config/ctafconf/perso/previous/"$src".mine ]; then

#     #diff between 2 upstream version, then patch
#     cp ~/.config/ctafconf/perso/previous/"$src".mine $tmp_f1
#     cp ~/.config/ctafconf/etc/mine/"$src".mine $tmp_f2

#     cp ~/.config/ctafconf/perso/$src.mine $tmp_patch 2>/dev/null
#     diff -c $tmp_f1 $tmp_f2 >$tmp_diff

#     if ! cat $tmp_diff | patch -c -f $tmp_patch 2>/dev/null; then
#       echo "patch dont suceeded"
#       #diff between previous and user version, then patch new upstream
#       cp ~/.config/ctafconf/perso/previous/"$src".mine $tmp_f1
#       cp ~/.config/ctafconf/perso/"$src".mine $tmp_f2

#       cp ~/.config/ctafconf/etc/mine/$src.mine $tmp_patch 2>/dev/null
#       diff -c $tmp_f1 $tmp_f2 >$tmp_diff
#       if ! cat $tmp_diff | patch -c -f $tmp_patch 2>/dev/null; then
#         echo "patch dont suceeded"
#       fi
#     fi
#     patchfile="`echo 'You have modified '$src'.mine, do you want to apply the current diff to '$src'.mine (I think yes)?;'`"
#     patchfile=$patchfile`diff -c ~/.config/ctafconf/perso/$src.mine $tmp_patch`

#     if ssft_yesno "Change in user file detected" "$patchfile"; then
#       echo "patchinggg"
#       #cat $tmp_diff | patch -b -u ~/.config/ctafconf/perso/"$src".mine
#     fi

#   else
#    ssft_display_message "Change in user-specific file" "The file $src.mine have been updated upstream. You should compare ~/.config/ctafconf/etc/mine/$src.mine and your's ~/.config/ctafconf/perso/$src.mine"
#  fi
}
