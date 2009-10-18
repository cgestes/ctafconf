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

#the project name
SET(PROJNAME "foobar")

#sources list
SET(SRC "main.cpp main.h")

#library to link with
SET(PROJLIB "")

#verbose output?
SET(CMAKE_VERBOSE_MAKEFILE OFF)

#flags?
SET(CFLAG -Wall -O2)

###############################
# The makefile                #
###############################
PROJECT(${PROJNAME})
CMAKE_MINIMUM_REQUIRED(VERSION 2.4)

#add definitions, compiler switches, etc.
ADD_DEFINITIONS(${CFLAGS})

#do you want an executable or a library?
ADD_EXECUTABLE(${PROJNAME} ${SRC})
#ADD_LIBRARY(${PROJNAME} ${SRC})

#need to link to some other libraries ? just add them here
TARGET_LINK_LIBRARIES(${PROJNAME} ${PROJLIB})
