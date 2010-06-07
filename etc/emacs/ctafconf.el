;;
;; Author(s):
;;  - Cedric GESTES <gestes@aldebaran-robotics.com>
;;
;; Copyright (C) 2010 Cedric GESTES
;;

;;;PATH and .el file
;; current directory
(setq ctafconf-path (file-name-directory (or load-file-name buffer-file-name)))

;;setup standard path
(setq load-path (nconc (list ctafconf-path
			     (concat ctafconf-path "site-lisp/")
			     (concat ctafconf-path "site-lisp/mode")
			     ) load-path))

;;debug those file on error
(setq debug-on-error t)
;;;;This sets garbage collection to hundred times of the default.
;;;;Supposedly significantly speeds up startup time. (Seems to work
;;;;for me,  but my computer is pretty modern. Disable if you are on
;;;;anything less than 1 ghz).
(setq gc-cons-threshold 50000000)

(load "safe-load")

(safe-load "ctafconf_color")

;;emacs settings
(safe-load "ctafconf_settings")

;;startup message
(safe-load "ctafconf_startup")

;;mode (ada,tuareg, ido, autotemplate,..)
(safe-load "ctafconf_mode")

;;usefull functions
(safe-load "ctafconf_functions")

;;screensaver,
;;(safe-load "~/.config/ctafconf/etc/emacs/misc.emacs")

;;cparse, cpcomment, cwarn, cedet, ecb, semantic
(safe-load "ctafconf_prog")

;;keys bindings
(safe-load "ctafconf_bindings")

(safe-load "ctafconf_profile")

;;print debug info
(safe-load-check)
