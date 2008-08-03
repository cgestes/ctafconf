##
## Login : <ctaf42@localhost.localdomain>
## Started on  Tue Mar  4 22:41:00 2008 Cedric GESTES
## $Id$
##
## Author(s):
##  - Cedric GESTES <ctaf42@gmail.com>
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
## gtk-ctafconf template

input:user-profile
  overwrite=true
  output=

frame:ctafconf
  string:ctafconf_name
    desc=
    regexp=ct-var-regexp

  string:ctafconf_mail
    regexp=ct-var-regexp

  singlechoice:ctafconf_zprompt
    desc=choose the zsh prompt you want
    regexp=ct-var-regexp
    default=ctaf
    value=ctaf
    value=adam1
    value=adam2
    value=bart
    value=zefram
    value=fade
    value=redhat
    value=suse
    value=walters
    value=bigfade
    value=clint
    value=elite
    value=elite2
    value=fire
    value=off
    value=olivier

  singlechoice:ctafconf_wm
    desc=
    regexp=ct-var-regexp
    value=fluxbox
    value=gnome
    value=kde
    value=xfce4
    value=e16
    value=term
    value=aterm

  multichoice:ctafconf_color
    desc=Use color for?
    desc=(disabling color could help to remove bug due to color (interacting with nano, or other console text editor))
    desc=Tips: use svn_real, cvs_real, make_real and gmake_real to get the real command
    default=svn
    default=cvs
    default=make
    default=gmake
    value=svn
    value=cvs
    value=make
    value=gmake

frame:ctafconf
  desc=This frame let you manage ctafconf packages.
  button:install
    action:install

  button:update
    action:shell
    cmd=cd ~/.config/ctafconf
    cmd=svn up

  multichoice:ctafconf_backlist
    regexp=ct-var-regexp
#     default=xsession
    value=zsh
    value=bash
    value=ksh
    value=tcsh
    value=emacs
    value=screen
    value=top
    value=vim
    value=e16
    value=fluxbox
    value=gnome
    value=namo
    value=torsmo
    value=xsession

  button:Change the wallpaper
    default=wallpaper
