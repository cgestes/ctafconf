;;
;; compile.el
;; Login : <speedblue@morpheus>
;; Started on  Wed Nov 13 21:55:06 2002 Julien LEMOINE
;; $Id: compile_conf.el,v 1.3 2002/12/03 10:22:23 pepe Exp $
;; 
;; Copyright (C) @YEAR@ Julien LEMOINE
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
;;

;; This file launch the compilation of the HappyCoders Emacs configuration

;; Need to load conf to compile it
(load "~/.emacs")
;; compile all .el
(byte-compile-file "~/emacs-config/cparse.el")
(byte-compile-file "~/emacs-config/auto-template.el")
(byte-compile-file "~/emacs-config/autoinsert.el")
(byte-compile-file "~/emacs-config/calculator.el")
(byte-compile-file "~/emacs-config/cpcomment.el")
(byte-compile-file "~/emacs-config/cproto.el")
(byte-compile-file "~/emacs-config/ctypes.el")
(byte-compile-file "~/emacs-config/cwarn.el")
(byte-compile-file "~/emacs-config/echeck.el")
(byte-compile-file "~/emacs-config/eiffel-mode.el")
(byte-compile-file "~/emacs-config/headers.el")
(byte-compile-file "~/emacs-config/norme.el")
(byte-compile-file "~/emacs-config/parse.el")
(byte-compile-file "~/emacs-config/reindent.el")
(byte-compile-file "~/emacs-config/std_comment.el")
(byte-compile-file "~/emacs-config/tiger.el")
(byte-compile-file "~/emacs-config/tuareg/camldebug.el")
(byte-compile-file "~/emacs-config/tuareg/custom-tuareg.el")
(byte-compile-file "~/emacs-config/tuareg/sym-lock.el")
(byte-compile-file "~/emacs-config/tuareg/tuareg.el")
;;(byte-compile-file "~/emacs-config/compile.el")
(byte-compile-file "~/emacs-config/redo.el")
(byte-compile-file "~/emacs-config/post.el")
(byte-compile-file "~/emacs-config/multi-mode.el")
;;(byte-compile-file "~/emacs-config/interface.el")
(byte-compile-file "~/.emacs")
