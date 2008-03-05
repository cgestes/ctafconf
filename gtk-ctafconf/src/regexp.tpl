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

##################
## REGEXP ALIAS ##
##################

regexp:ct-var
  readregexp=^var_set ([a-zA-Z_]+) (.*)$
  writeregexp=^/var_set (%1) (%2)$

regexp:ct-env
  readregexp=^env_set ([a-zA-Z_]+) (.*)$
  writeregexp=^/env_set (%1) (%2)$

regexp:ct-alias
  readregexp=^alias_set ([a-zA-Z_]+) (.*)$
  writeregexp=^/alias_set (%1) (%2)$

#readregexp:
# the first () math the NAME
# the second () math the VALUE
#
#writeregexp:
# ?1, ?2: the place in the readregexp (where to replace)
# %1, %2: new values from user input (name, value)

regexp:ct-lisp
  readregexp=^\(setq ([a-zA-Z_]+) (.*)\)$
  writeregexp=^/(?1$&)(?2%2)\)$

#optionnal
  bool_true=t
  bool_false=nil
  list_separator=,

