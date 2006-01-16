#
# @FILE-NAME@
# Login : <@USER-LOGIN@@@HOST@>
# Started on  @DATE-STAMP@ @USER-NAME@
# $@Id@$
# 
# Copyright (C) @YEAR@ @USER-NAME@
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
#

require "fileinto";

#
# Vacation rules - uncomment and modify accordingly if you wish to use the vacation. 

#require "vacation";

#Set the time in days of your vacation here
# Replace xxxxxx with the number of days.
#
#vacation :days xxxxxx :addresses

# set your email addresses here. Include any aliases you are known by
#["dcsano@bath.ac.uk", "A.N.Other@bath.ac.uk"]
#"
#-- This is an automatic reply.  
#-- Feel free to send additional mail, 
#-- as only this one notice will be generated.
#
# enter the contents of your mesage below:
#
#Thanks for your message.
#I will be away from the office soon. 
#Please ring x0000 or email 
#mailto:email@bath.ac.uk 
#for enquiries.
#
#A.N.Other
#** This message was generated automatically **";
#

# This will silently discard most spam

if exists "X-RBL-Warning" {
    discard;
}

# modify and add additional lines below as required to filter mail
# Then uncomment the lines to make active.
#
#elsif header :contains ["to", "cc"] "address@bath.ac.uk" {
#	fileinto "INBOX.support" ;}
#elsif header :contains ["to", "cc"] "address@bath.ac.uk" {
#	fileinto "INBOX.webmaster" ;}
#elsif header :contains ["to", "cc"] "address@bath.ac.uk" {
#	fileinto "INBOX.lanmaster";}
#
#


#Modify below to discard specific email based on subject
# Then uncomment the lines to make active.
#
#elsif header :contains "Subject" "MAKE MONEY FAST" {
#    discard;
#}

#Modify below to discard specific email based on From: address
#Then uncomment the lines to make active.
#
#elsif header :contains "From" "email@junk.com" {
#    discard;
#}


#Modify below to discard specific email based on To: address
#Then uncomment the lines to make active.
#
#elsif header :contains "To" "email@junk.com" {
#    discard;
#}

# Can repeat the above with cc: and bcc: addresses
