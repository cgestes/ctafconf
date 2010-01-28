#!/usr/bin/env python
##
## ct-install.py
## Login : <ctaf@ctaf-maptop>
## Started on  Sun Jan 17 12:57:42 2010 Cedric GESTES
## $Id$
##
## Author(s):
##  - Cedric GESTES <ctaf42@gmail.com>
##
## Copyright (C) 2010 Cedric GESTES
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

import logging
import sys
import os
import shutil
import difflib #does not work in python (does in ipython?), i should investigate
import filecmp

logging.basicConfig(level=logging.WARNING)

LOGGER = logging.getLogger('grk-install')
LOGGER.setLevel(logging.DEBUG)

DEST_DIR = os.path.expanduser("~")
SRC_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")

def grk_file():
  LOGGER.debug("grk_file")
  pass

def grk_dir():
  LOGGER.debug("grk_dir")
  pass

def get_backup_filename(fname):
  """ return a filename.<id>
  id is incremented as needed

  WARNING this function could return an invalid filename
  if an the input filepath is not correct
  """

  bid = 0
  while true:
    backup = "%s.%d" % (fname + bid)
    bid = bid + 1
    if not os.path.exists(backup):
      return backup


def grk_backup_file(fname, src = None):
  """
  if src is specified and fname and src are identical do nothing

  if <fname>.original exists:
    copy fname to fname.backup.(date)
  else
    copy fname to fname.original (if fname.original does not exist)
  """
  LOGGER.debug("grk_backup_file(%s, %s)" % (fname, src))

  original = os.path.join(fname, ".original")

  if not os.path.exists(fname):
    LOGGER.warning("grk_backup_file: %s doest not exits", fname)
    return

  #first installation, create .original
  if not os.path.exists(original):
    LOGGER.info("copy %s to %s", fname, original)
    #shutil.copyfile(fname, original)
    return

  #backup as fname.date
  backup = get_backup_filename(fname)
  LOGGER.info("backup: %s to %s", fname, backup)
  #shutil.copyfile(fname, backup)
  pass

def grk_install_file(dest, src):
  """
  - check if file exists
  - backup dest (with grk_backup_file)
  """
  LOGGER.debug("grk_install_file(%s, %s)" % (str(dest), str(src)))

  dest_abs = os.path.abspath(os.path.join(DEST_DIR, dest))
  LOGGER.debug("dest abs: %s" % (dest_abs))

  src_abs = os.path.abspath(os.path.join(SRC_DIR, src))
  LOGGER.debug("src abs: %s" % (src_abs))

  #check if fname and src are identical
  if filecmp.cmp(src_abs, dest_abs):
    print "identical:", src_abs, dest_abs
    return

    #TODO
    #f = open(src, "r")
    #src_content = f.readlines()
    #f.close()
    #f = open(fname, "r")
    #dest_content = f.readlines()
    #f.close()

    #d = difflib.Differ()
    #ret = d.compare(src_content, dest_content)
    #if ret:
    #  print ret
    #  return

  if (os.path.exists(dest_abs)):
    #LOGGER.info("the configuration file : %s exits, creating a backup", dest_abs)
    grk_backup_file(dest_abs, src_abs)

  print "installing: %s to %s" % (src_abs, dest_abs)
  #shutil.copyfile(src, dest_abs)
  pass

def grk_uninstall_file(dest):
  LOGGER.debug("grk_uninstall_file", dest)
  pass


def grk_install(grksetup):
  """
  - install a grksetup file
  """
  LOGGER.debug("grk install")
  for grk in grksetup.FILES:
    #todo check type
    grk_install_file(grk[0], grk[1])

  pass

class GrkSetup:
  """
  contains a list of file to install
  """
  pass

class GrkSetupZsh:
  FILES = [ ( ".zshrc",   "etc/zsh/zshrc") ]
  #etc/zsh/zshenv ~/.zshenv zshenv

class GrkSetupBash:
  FILES = [ ( ".bashrc",  "etc/bash/bashrc") ]

class GrkSetupNano:
  FILES = [ (".nanorc",   "etc/nano/nanorc") ]

class GrkSetupTop:
  FILES = [ (".toprc",    "etc/top/toprc") ]

class GrkSetupEmacs:
  FILES = [ (".emacs",    "etc/emacs/emacs") ]

class GrkSetupScreen:
  FILES = [ (".screenrc", "etc/screen/screenrc") ]

class GrkSetupVim:
  FILES = [ (".vimrc",    "etc/vim/vimrc"),
            (".gvimrc",   "etc/vim/gvimrc") ]

#   FILES = [ ("~/.fluxbox" "etc/fluxbox/init") ]
#   FILES = [ ("~/.xinitrc" "etc/xsession/xsession") ]
#   FILES = [ ("~/.xsession" "etc/xsession/xsession") ]
#  FILES = [ ("lua" "etc/ion3/ctafconf") ]
PACKAGES = [ GrkSetupZsh,
             GrkSetupBash,
             GrkSetupNano,
             GrkSetupTop,
             GrkSetupEmacs,
             GrkSetupScreen,
             GrkSetupVim ]

if __name__ == "__main__":


  for grk in PACKAGES:
    grk_install(grk)

