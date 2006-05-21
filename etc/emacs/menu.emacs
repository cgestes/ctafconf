;;
;; menu.emacs for ctafconf in /home/ctaf/.ctafconf/etc/emacs/site-lisp
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 05:39:19 2006 GESTES Cedric
;; Last update Sun May 21 04:17:46 2006 GESTES Cedric
;;


(require 'menu-bar)

;; organized buffer menu
(msb-mode 1)

;; add entry to menu-bar:
(defvar menu-bar-jj-menu (make-sparse-keymap "ctafconf"))
(define-key global-map [menu-bar ctafconf] (cons "ctafconf" menu-bar-jj-menu))

;; Menu entries (the numbers [item-NN] don't affect the order):
;;
;; First entry here is lowest in menu.
(define-key menu-bar-jj-menu [item-01]
  '("start ecb" . ecb-activate))

(define-key menu-bar-jj-menu [item-02]
  '("stop ecb" . ecb-deactivate))

(define-key menu-bar-jj-menu [item-03]
  '("compile" . compile))

(define-key menu-bar-jj-menu [item-04]
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
