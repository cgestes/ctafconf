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


input:emacs.config
frame:emacs
  checkbox:enable-scroll-bar
    regexp=ct-lisp-regexp

  checkbox:enable-menu-bar
    regexp=ct-lisp-regexp

  checkbox:enable-tool-bar
    regexp=ct-lisp-regexp

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

