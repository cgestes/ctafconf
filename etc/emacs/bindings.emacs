;;
;; bindings.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 01:16:47 2006 GESTES Cedric
;; Last update Thu Jan 19 16:05:42 2006 GESTES Cedric
;;
(message "ctafconf loading: BINDINGS.EMACS")

(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)


(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)

(global-set-key [S-right]       'next-buffer)
(global-set-key [S-left]        'prev-buffer)



;; M-x pc-bindings-mode sets up bindings compatible with many PC editors. In particular, Delete and its variants delete forward instead of backward. Use Backspace to delete backward.
;; C-Backspace kills backward a word (as C-Delete normally would).
;; M-Backspace does undo.
;; Home and End move to beginning and end of line
;; C-Home and C-End move to beginning and end of buffer.
;;(pc-bindings-mode)
;;use shift + left/right to select something
;;(pc-selection-mode)

(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(global-set-key [backward-delete-char] 'backward-delete-char)
(global-set-key [C-delete] 'kill-word)
(global-set-key [C-kp-delete] 'kill-word)
(global-set-key [C-backward-delete-char] 'backward-kill-word)

;;;;CLAVIER
(global-set-key "\C-c\C-z" 'zlock)

;;changement de buffer ac ctrl+tab
(global-set-key [(control tab)] 'other-window)

;;appelle la derniere macro enregistré
(global-set-key "\C-z" 'call-last-kbd-macro)

(global-set-key [f1] (lambda ()
		       (interactive)
		       (manual-entry (current-word))))

(global-set-key [(shift f1)] (lambda ()
		       (interactive)
		       (manual-entry (current-word) 3)))

(global-set-key [f2] 'norme)
(global-set-key [(shift f2)] 'xterm-mouse-mode)
(global-set-key [f14] 'xterm-mouse-mode)

(global-set-key [f3] 'query-replace)
(global-set-key [(shift f3)] 'replace-string)
(global-set-key [f15] 'replace-string)

(global-set-key [f4] 'comment-region)
(global-set-key [(shift f4)] 'uncomment-region)
(global-set-key [f16] 'uncomment-region)

(global-set-key [f5] 'ansi-term)
(global-set-key [(shift f5)] 'speedbar)
(global-set-key [f17] 'speedbar)

;;(global-set-key [f6] 'comment-region)
;;(global-set-key [(shift f6)] 'uncomment-region)
;;(global-set-key [f18] 'uncomment-region)
(global-set-key [f7] 'next-error)
(global-set-key [(shift f7)] 'previous-error)
(global-set-key [(f19)] 'previous-error)

;;(global-set-key [f7] 'comment-region)
;;(global-set-key [(shift f7)] 'uncomment-region)
;;(global-set-key [f19] 'uncomment-region)

(global-set-key [f8] 'compile)
(global-set-key [(shift f8)] 'gdb)
(global-set-key [f20] 'gdb)

(global-set-key [(f12)] '(lambda() (interactive) (scroll-other-window -1)))
(global-set-key [(shift f12)] '(lambda() (interactive) (scroll-other-window 1)))
(global-set-key [(f24)] '(lambda() (interactive) (scroll-other-window 1)))
(global-set-key [(control backspace)] 'join-line)
;;goto line= alt+l
(global-set-key "\M-l" 'goto-line)


(global-set-key [(C-b)] 'electric-buffer-list)
