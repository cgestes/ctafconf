#!/bin/sh
## lin2win.sh for lin2in in /home/gestes_c/bin
## 
## Made by Gestes Cedric
## Login   <gestes_c@epita.fr>
## 
## Started on  Thu Jan  6 04:55:51 2005 Gestes Cedric
## Last update Thu Jan  6 04:57:25 2005 Gestes Cedric
##

if [ $# -ne 1 ]; then
 echo 'usage lin2win file.lin'
 echo 'create file.lin.win with crlf as line terminal'
 exit
fi

cat $1 | sed -e  s/$//  > $1.win
