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

include:regexp.tpl

input:user-profile
frame:test
  string:ctafconf_name
    default=
    getregexp=^var_set ([a-zA-Z_]+) (.*)$

  string:ctafconf_mail
    default=
    regexp=ct-var
    getregexp=^var_set ([a-zA-Z_]+) (.*)$

  string:ctafconf_zprompt
    regexp=ct-var
    getregexp=^var_set ([a-zA-Z_]+) (.*)$

  string:ctafconf_wm
    regexp=ct-var
    getregexp=^var_set ([a-zA-Z_]+) (.*)$

  string:ctafconf_backlist
    regexp=ct-var
    getregexp=^var_set ([a-zA-Z_]+) (.*)$

  singlechoice:THEsinglechoice
    value=bande
    value=branle
    value=donne tout
    default=bande

  multichoice:THEmultichoice
    value=bande
    value=branle
    value=donne tout
    default=bande
    default=donne tout





frame:ctafconf
  button:install
    action:install

  button:update
    action:shell
    cmd=cd ~/.config/ctafconf
    cmd=svn up

  multichoice:backlisted package
    default=xsession
    value=zsh
    value=gnome
    value=xsession
    value=bash

  button:Change the wallpaper
    default=wallpaper


frame:emacs
  string:email
  string:complete user name
  checkbox:fixed windows size
  int:window width
  int:window height
  checkbox:cedet

# -- devel
#  - ilisp
#  - cedet
#  - ..
#  - custom template directory

frame:SHELL
  checkbox:use-color
# - env var
# - alias
# (allow to override existing, and to see them)
# - perso/*.mine
# - ct-env integration


frame:ADM-CONFIG
  singlechoice:zsh prompt
   default=ctaf
   value=hctaf
   value=blabla2
   value=ctaf
   value=blabla4

  singlechoice: window manager
    value=bob
    default=bob


frame:REMINDER

frame:DOC
# - emacs keys
# - shell keys
# - shell command
