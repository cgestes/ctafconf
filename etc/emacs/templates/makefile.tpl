##
## @FILE-NAME@
## Login : <@USER-LOGIN@@@HOST@>
## Started on  @DATE-STAMP@ @USER-NAME@
## $@Id@$
##
## Author(s):
##  - @USER-NAME@ <@USER-MAIL@>
##
## Copyright (C) @YEAR@ @USER-NAME@
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

##############################
# Complete this to make it ! #
##############################
NAME 	=		# Name of executable file
SRC	=		# List of *.c
INCL  	=		# List of *.h
################
# Optional add #
################
IPATH   = -I.           # path of include file
OBJOPT  = -O2 -Wall -Wstrict-prototypes       # option for obj
EXEOPT  = -O2 -Wall -Wstrict-prototypes       # option for exe (-lefence ...)
LPATH   = -L.           # path for librairies ...

#####################
# Macro Definitions #
#####################
CC 	= gcc
CXX 	= g++
MAKE 	= make
SHELL	= /bin/sh
OBJS 	= $(SRC:.c=.o) 	# WARNING!!! Be careful of your file extensions.
RM 	= /bin/rm -f
COMP	= gzip -9v
UNCOMP	= gzip -df
STRIP	= strip

CFLAGS  = $(OBJOPT) $(IPATH)
LDFLAGS = $(EXEOPT) $(LPATH)

.SUFFIXES: .h.Z .c.Z .h.gz .c.gz .c.z .h.z

##############################
# Basic Compile Instructions #
##############################

all:	$(NAME)
$(NAME): $(OBJS) $(SRC) $(INCL)
	$(CC) $(OBJS) $(LDFLAGS) -o $(NAME)
#	$(STRIP) ./$(NAME) # if you debug ,don't strip ...

depend:
	gcc $(IPATH) -MM $(SRC)
clean:
	-$(RM) $(NAME) $(OBJS) *~
fclean:
	-$(RM) $(NAME)
comp: clean
	$(COMP) $(INCL) $(SRC)
ucomp:
	$(UNCOMP) $(SRC) $(INCL)

check-syntax:
	$(MAKE) syntax-target CFLAGS="-fsyntax-only"

syntax-target: $(CHK_SOURCES:.c=.o)

.c.Z.c .h.Z.h .c.gz.c .h.gz.h .c.z.c .h.z.h :
	 -$(UNCOMP) $<

.c.o:
	$(CC) $(CFLAGS) -c $<
.cc.o:
	$(CXX) $(CFLAGS) -c $<
################
# Dependencies #
################
