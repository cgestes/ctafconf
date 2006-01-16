##
## @FILE-NAME@
## Login : <@USER-LOGIN@@@HOST@>
## Started on  @DATE-STAMP@ @USER-NAME@
## $@Id@$
## 
## Copyright (C) @YEAR@ @USER-NAME@
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

############################################################################
##### WARNING ! THIS FILE IS A TEMPLATE - EDIT IT BEFORE USING IT !! #######
############################################################################

## immediate subdirs
SUBDIRS = config src

## extra files
EXTRA_DIST = README TODO NEWS AUTHORS ChangeLog

noinst_HEADERS = header.hh


#######################
# Build an executable #
#######################

INCLUDES = -I $(top_builddir)/src

bin_PROGRAMS = fixme
fixme_SOURCES = fixme.cc
fixme_LDADD = dir1/libdir1.a

# Don't forget that the order of the libraries _does_ matter


##########
# Checks #
##########

TESTS = test-1.sh test-2
check_PROGRAMS = test-2
test_2_SOURCES = main_for_tests.cc


####################
# Additional Rules #
####################

re : clean all
