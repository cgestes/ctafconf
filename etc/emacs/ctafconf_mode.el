;;
;; mode.emacs for ctafconf in ~/.config/ctafconf/etc/emacs/mode.emacs
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Mon Jan 16 00:57:16 2006 GESTES Cedric
;; Last update Thu May  6 10:13:08 2010 Cedric GESTES
;;
(message ".")
(message "ctafconf loading: MODE.EMACS")




;;IDO MODE
;;IDO for find-file, and others
(condition-case err
    (progn
      (require 'ido)
      (ido-mode t)
      (setq ido-enable-flex-matching t) ; fuzzy matching is a must have
      )
  (error
   (message "Cannot load ido %s" (cdr err))))

;; ;;disable iswitchb
;; (if (iswitchb-mode nil)
;;     (iswitchb-mode nil)
;;     )

(global-set-key "\C-xb" 'electric-buffer-list)

;; this mode let you use emacs with the "modern editor bindings"
;; shift + left|right|up|down to make a selection
;; ctrl x, ctrl v, ctrl c
(if (boundp 'cua-mode)
    (cua-mode t))

;;;SavePlace- this puts the cursor in the last place you editted
;;;a particular file. This is very useful for large files.
;; REENABLE WHEN LESS MY SHELL CONF WILL BE LESS BUGGY (root write in /home/ctaf/.emacs-place)
;; (condition-case err
;;     (progn
;;       (require 'saveplace)
;;       (setq-default save-place t)
;;       )
;;   (error
;;    (message "Cannot load saveplace %s" (cdr err))))




(condition-case err
    (progn
      (require 'browse-kill-ring)
      )
  (error
   (message "Cannot load browse-kill-ring %s" (cdr err))))

(condition-case err
    (progn
      (require 'tabbar)
      (tabbar-mode t)
      )
  (error
   (message "Cannot load tabbar %s" (cdr err))))

(require 'generic)
(require 'generic-x)


