#!/bin/sh
#CTAFCONF configuration file

#set your name here (for git, emacs, ...)
var_set ctafconf_name ''

#set your mail here (for git, emacs, ...)
var_set ctafconf_mail ''

#set your prefered editor here (emacs, nano, vim, vi)
var_set ctafconf_editor 'emacs'

#list of specific configurations (ctaf, yannick, aldebaran)
#if you dont know => dont change this variables
#you can list availables profiles in .config/ctafconf/profile
var_set ctafconf_profile ''

#choose your zsh prompt
#choice are: ctaf adam1 adam2 bart zefram fade redhat suse walters bigfade clint elite elite2 fire off olivier
var_set ctafconf_zprompt 'ctaf'
