;;
;; menu.emacs for ctafconf in /home/ctaf/.ctafconf/etc/emacs/site-lisp
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 05:39:19 2006 GESTES Cedric
;; Last update Fri Feb  9 03:37:21 2007 GESTES Cedric
;;

;;
;;CTAFCONF
;;  display the help
;;  edit your personnal setting
;;  load ilisp
;;  load cedet
;;  load ecb
;;PROG
;;  add doxymacs headers
;;  add doxymacs function headers
;;  htmlize buffer

(require 'menu-bar)

;; organized buffer menu
(msb-mode 1)

;; add entry to menu-bar:
(defvar ctafconf-menu (make-sparse-keymap "ctafconf"))
(define-key global-map [menu-bar ctafconf] (cons "ctafconf" ctafconf-menu))

;; Menu entries (the numbers [item-NN] don't affect the order):
;;
;; First entry here is lowest in menu.
(define-key ctafconf-menu [item-01]
  '("start ecb" . ecb-activate))

(define-key ctafconf-menu [item-02]
  '("stop ecb" . ecb-deactivate))

(define-key ctafconf-menu [item-03]
  '("compile" . compile))

(define-key ctafconf-menu [item-04]
  '("htmlize buffer" . htmlize-buffer))

;;(provide 'menu)

;;; menu.el ends here
(require 'generic-menu)
(require 'generic-dl)

(defun grk-menu-buffer (val)
  "grk buffer menu"
  (message "buffer menu %S" val)
  )

(defun grk-menu-prog (val)
  "grk menu"
  (gm-quit)
  (if (equal val "function list")
      (progn
        (gm-quit)
        (dl-popup)))
  (if (equal val "compile")
      (compile))
  (if (equal val "debug")
      (debug))
  )

(defun grk-menu (val)
  "grk menu"
  (gm-quit)
  (if (equal val "buffer")
      (gm-popup :elements '("prout")
                :select-callback (lambda (val)
                                   (grk-menu-buffer val))))
  (if (equal val "prog")
      (gm-popup :elements '("function list" "compile" "debug")
                :select-callback (lambda (val)
                                   (grk-menu-prog val))))
  (if (equal val "misc")
      (message "You hace selected: %S" val))
  )


(defun grk-menu ()
 (gm-popup :elements '("buffer" "prog" "misc")
           :select-callback (lambda (val)
                              (grk-menu val)))
 )
