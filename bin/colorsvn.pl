#!/usr/bin/env perl
#
# colorsvn.pl 0.1
#
# Copyright: (C) 1999, 2010, Bjarni R. Einarsson <bre@netverjar.is>
#                      http://bre.klaki.net/
# adapted from colormake by ctaf42@gmail.com
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

$col_red =          "\033[31m";
$col_green =        "\033[32m";
$col_yellow =       "\033[33m";
$col_brown =        "\033[33m";
$col_blue =         "\033[34m";
$col_purple =       "\033[35m";
$col_cyan =         "\033[36m";
$col_ltgray =       "\033[37m";
$col_norm =	    "\033[00m";
$col_background =   "\033[07m";
$col_brighten =     "\033[01m";
$col_underline =    "\033[04m";
$col_blink = 	    "\033[05m";
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
# Customize colors here...
#apocalypto
#
$col_default =        $col_ltgray;
$col_update =         $col_cyan;
$col_added =          $col_brown;
$col_conflict =       $col_red;
$col_deleted =        $col_brown;
$col_fusion =         $col_blue;
$col_file =           $col_norm;
$tag_error =          "Error: ";
$col_error =          $tag_error . $col_brown . $col_brighten;
$error_highlight =    $col_brighten;

# Get size of terminal
#
$lines = shift @ARGV || 0;
$cols  = shift @ARGV || 0;
$cols -= 19;

sub is_interactive {
  return -t STDOUT;
}

$in = 'unknown';
$| = 1;
while (<>)
{
  if (!is_interactive()) {
    print $_;
    next;
  }
  $orgline = $thisline = $_;

  # Remove multiple spaces
  $thisline =~ s/  \+/ /g;

  # Truncate lines.
  # I suppose this is bad, but it's better than what less does!
  if ($cols >= 0) {
    $thisline =~ s/^(.{$cols}).....*(.{15})$/$1 .. $2/;
  }
  #svn up
  $thisline =~ s/^(C)\s\s*(.*)/$col_conflict$1onflict: $col_file$2/x;
  $thisline =~   s/^(U)\s\s*(.*)/$col_update$1pdated : $col_file$2/x;
  $thisline =~   s/^(G)\s\s*(.*)/$col_fusion$1 Merged: $col_file$2/x;
  $thisline =~    s/^(A)\s\s*(.*)/$col_added$1dded   : $col_file$2/x;
  $thisline =~  s/^(D)\s\s*(.*)/$col_deleted$1eleted : $col_file$2/x;

  #svn status
  $thisline =~ s/^(\~)\s\s*(.*)/$col_conflict$1       : $col_file$2/x;
  $thisline =~     s/^(\?)\s\s*(.*)/$col_file$1       : $col_file$2/x;
  $thisline =~ s/^(\!)\s\s*(.*)/$col_conflict$1       : $col_file$2/x;
  $thisline =~    s/^(M)\s\s*(.*)/$col_update$1odified: $col_file$2/x;
  $thisline =~    s/^(R)\s\s*(.*)/$col_update$1eplaced: $col_file$2/x;
  $thisline =~    s/^(X)\s\s*(.*)/$col_fusion$1       : $col_file$2/x;
  $thisline =~      s/^(I)\s\s*(.*)/$col_file$1gnored : $col_file$2/x;

  #svn diff
  $thisline =~   s/^(\Index.*)/$col_yellow$col_brighten$1$col_file/x;
  $thisline =~   s/^(\===.*)/$col_yellow$col_brighten$1$col_file/x;

  $thisline =~   s/^(\-\-\-.*)/$col_yellow$col_brighten$1$col_file/x;
  $thisline =~   s/^(\+\+\+.*)/$col_yellow$col_brighten$1$col_file/x;

  $thisline =~   s/^(\+.*)/$col_purple$1$col_file/x;
  $thisline =~   s/^(-.*)/$col_yellow$1$col_file/x;
  $thisline =~   s/^(@@.*)/$col_blue$1$col_file/x;


  if ($thisline !~ /^\s+/)
  {
    print $col_norm, $col_default;
  }
  print $thisline;
}

if (is_interactive()) {
  print $col_norm;
}
