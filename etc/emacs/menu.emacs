;;
;; menu.emacs for ctafconf in /home/ctaf/.ctafconf/etc/emacs/site-lisp
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 05:39:19 2006 GESTES Cedric
;; Last update Fri May 12 21:50:49 2006 GESTES Cedric
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
