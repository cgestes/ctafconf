#!/usr/bin/env perl
#
# colormake.pl 0.3
#
# Copyright: (C) 1999, Bjarni R. Einarsson <bre@netverjar.is>
#                      http://bre.klaki.net/
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#


# Some useful color codes, see end of file for more.
#
$col_black =        "\033[30m";
$col_red =          "\033[31m";
$col_green =        "\033[32m";
$col_brown =        "\033[33m";
$col_blue =         "\033[34m";
$col_purple =       "\033[35m";
$col_cyan =         "\033[36m";
$col_white =        "\033[37m";
$col_ltgray =       "\033[37m";

$col_norm =	    "\033[00m";
$col_background =   "\033[07m";
$col_brighten =     "\033[01m";
$col_underline =    "\033[04m";
$col_blink = 	    "\033[05m";

# Customize colors here...
#
$col_default =      $col_norm . $col_brighten;
$col_gcc =          $col_brigthen . $col_purple ;
$col_make =         $col_brighten . $col_cyan;
$col_filename =     $col_brighten . $col_brown;
$col_linenum =      $col_brighten . $col_cyan;
$col_trace =        $col_norm . $col_cyan;
$col_warning =      $col_brighten . $col_green;
$col_error =        $col_brighten . $col_red;
$error_highlight =  $col_brighten;

$| = 1;
while (<>)
{
    $orgline = $thisline = $_;

    $thisline =~ s|^(.*:\s*)(\d+\s*:\s*)(.*)|$col_filename$1$col_linenum$2$col_default$3|x;
    print $thisline;
}

print $col_default;

