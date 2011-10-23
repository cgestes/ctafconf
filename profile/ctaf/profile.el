;;
;; Author(s):
;;  - Cedric GESTES <ctaf42@gmail.com>
;;
;; Copyright (C) 2010 Cedric GESTES
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or
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

;;--------------------------------------------------------------------
;; support de mon clavier en mode console
(set-terminal-coding-system 'iso-8859-15-unix)
(set-keyboard-coding-system 'iso-8859-15-unix)
(set-language-environment 'Latin-1)


; make scripts executable upon saving
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;;update copyright years in headers
(add-hook 'before-save-hook 'copyright-update)

;;(ctafconf-ropemacs)

(message "using ctaf emacs profile")
