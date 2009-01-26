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

    # Remove multiple spaces
    $thisline =~ s/  \+/ /g;

    #make[1] | make:
    $thisline =~ s/^((p|g)?make)(\[[1234567890]*\]|:)(.*$)/$col_make$1$col_norm$col_brown$3$col_trace$4$col_default/x;
    $thisline =~ s/^(\s*(g?cc|(g|c)\+\+))/$col_gcc$1$col_default/x;
#     $thisline =~ s/^(.*(libtool\s)*.*(g?cc|(g|c)\+\+))$/$col_gcc$1$col_norm/x;
#     $thisline =~ s/^(((\t|\s)*then\s))$/$col_gcc$1$col_norm/x;
#    $thisline =~ s/^(\s*\(|\[|a(r|wk)|c(p|d|h(mod|own))|do(ne)?|e(cho|lse)|f(ind|or)|i(f|nstall)|mv|perl|r(anlib|m(dir)?)|s(e(d|t)|trip)|tar)\s+/$col_gcc$1 $col_default/x;

#     $thisline =~ s/(In (member\s)+f(unction|ile))/$col_trace$1$col_normal/x;

    #filename: In function:
    $thisline =~ s/^(.*:\s*)(In\s|At\s)(.*)/$col_filename$1$col_trace$2$3$col_default/x;

    #filename: 123: error: ...
    $thisline =~ s|^(.*:\s*)(\d+\s*:\s*)(error\s*:\s+)(.*)|$col_filename$1$col_linenum$2$col_underline$col_error$3$col_norm$col_purple$4$col_default|x;
    $thisline =~ s|^(.*:\s*)(\d+\s*:\s*)(erreur\s*:\s+)(.*)|$col_filename$1$col_linenum$2$col_underline$col_error$3$col_norm$col_purple$4$col_default|x;
    #filename: 123: warning: ...
    $thisline =~ s|^(.*:\s*)(\d+\s*:\s*)(attention\s*:\s+)(.*)|$col_filename$1$col_linenum$2$col_underline$col_warning$3$col_norm$col_brighten$col_purple$4$col_default|x;
    #filename: 123:
    $thisline =~ s|^(.*:\s*)(\d+\s*:\s*)()(.*)|$col_filename$1$col_linenum$2$col_underline$col_warning$3$col_norm$col_brighten$col_purple$4$col_default|x;

    $thisline =~ s|^(.*:\s*)(\d+\s*:\s*)(warning\s*:\s+)(.*)|$col_filename$1$col_linenum$2$col_underline$col_warning$3$col_norm$col_brighten$col_purple$4$col_default|x;

    print $thisline;
}

print $col_default;

# UNUSED:
#
#%colors = (
#    'black'     => "\033[30m",
#    'red'       => "\033[31m",
#    'green'     => "\033[32m",
#    'yellow'    => "\033[33m",
#    'blue'      => "\033[34m",
#    'magenta'   => "\033[35m",
#    'purple'    => "\033[35m",
#    'cyan'      => "\033[36m",
#    'white'     => "\033[37m",
#    'darkgray'  => "\033[30m");



