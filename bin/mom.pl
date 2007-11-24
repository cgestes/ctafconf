#!/usr/bin/env perl
##
## mom.sh
## Login : <ctaf@CTAF-FIX.CTAFLAND>
## Started on  Sat Nov 24 11:48:46 2007 GESTES Cedric
## $Id$
##
## Copyright (C) 2007 GESTES Cedric
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

# merge'o'matic baby!


#keep the header and footer of ARG0, and merge it with the body of ARG1

$begpattern="AUTOMAGIC START";
$endpattern="AUTOMAGIC END";

$take1=1;
$take2=0;
open (FH1,$ARGV[0]) or die "Can't open $ARGV[0]: $!\n";
open (FH2,$ARGV[1]) or die "Can't open $ARGV[1]: $!\n";

print "$ARGV[0]\n";
print "$ARGV[1]\n";
while (<FH1>) {
    $thisline = $_;
    if ($thisline =~ /$begpattern/) {


        while (<FH2>) {
            $thisline2 = $_;
            if ($thisline2 =~ /$begpattern/) {
                $take2 = 1;
            }
            if ($thisline2 =~ /$endpattern/) {
                print "$thisline2";
                $take2 = 0;
            }
            if ($take2 == 1) {
                print "$thisline2";
            }
        }
        $take1=0;


    } elsif ($thisline =~ /.*$endpattern.*/) {
            $take1 = 1;
    } elsif ($take1 == 1) {
        print "$thisline";
    }
}

