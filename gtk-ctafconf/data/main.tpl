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

input:emacs.config
frame:emacs
  checkbox:ctafconf-ilisp
    regexp=ct-lisp-regexp

  checkbox:ctafconf-zone
    regexp=ct-lisp-regexp

  checkbox:ctafconf-cedet
    regexp=ct-lisp-regexp

  checkbox:ctafconf-ecb
    regexp=ct-lisp-regexp

  checkbox:ctafconf-fixed-window-size
    regexp=ct-lisp-regexp

  checkbox:ctafconf-fixedsize
    regexp=ct-lisp-regexp

  checkbox:ctafconf-menubar
    desc="draw the menu bar?"
    default=nil

  folder:ctafconf-custom-template-dir
    desc="custom template folder for emacs"

  checkbox:fixed-windows-size
    desc="start emacs with a fixed windows size?"
    default=nil

  int:window-width
    df=
  int:window-height
    dtc=


frame:SHELL
# - user-profile
# - some keys from env and alias, duplicated if needed (stored in perso)
# - emacs
#   - fonctionnalité activé (ilisp/cedet/...)
#   - some var: indentation/menu-bar/size
#   - w-o-b / b-o-w ??
#   - username/mail
#   - keybindings
# - zsh
# - bash
# - prompt option (transparent/w-o-b/b-o-w)


# DOC
#   - alias
#   - variable d'environnement
#   - ct-env
#   - ct-date
#   - ct-ssh
#   - emacs



# -- devel
#  - ilisp
#  - cedet
#  - ..
#  - custom template directory

# frame:SHELL
#   checkbox:use-color
# - env var
# - alias
# (allow to override existing, and to see them)
# - perso/*.mine
# - ct-env integration


# frame:ADM-CONFIG
#   singlechoice:zsh prompt
#    default=ctaf
#    value=hctaf
#    value=blabla2
#    value=ctaf
#    value=blabla4

#   singlechoice: window manager
#     value=bob
#     default=bob


# frame:REMINDER

# frame:CT-DATE
# frame:DOC
# - emacs keys
# - shell keys
# - shell command
