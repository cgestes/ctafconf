;;
;; bindings.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Mon Jan 16 01:16:47 2006 GESTES Cedric
;; Last update Thu May 27 19:28:26 2010 Cedric GESTES
;;
(message ".")
(message "ctafconf loading: BINDINGS.EMACS")

(global-set-key [M-left]       'tabbar-backward-tab)
(global-set-key [M-right]        'tabbar-forward-tab)

(global-set-key [M-up]       'tabbar-backward-group)
(global-set-key [M-down]        'tabbar-forward-group)


;; M-x pc-bindings-mode sets up bindings compatible with many PC editors. In particular, Delete and its variants delete forward instead of backward. Use Backspace to delete backward.
;; C-Backspace kills backward a word (as C-Delete normally would).
;; M-Backspace does undo.
;; Home and End move to beginning and end of line
;; C-Home and C-End move to beginning and end of buffer.
;;(pc-bindings-mode)
;;use shift + left/right to select something
;;(pc-selection-mode)
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(global-set-key [backward-delete-char] 'backward-delete-char)
(global-set-key [C-delete] 'kill-word)
(global-set-key [C-kp-delete] 'kill-word)
(global-set-key [C-backward-delete-char] 'backward-kill-word)

(global-set-key [(control backspace)] 'join-line)

;;changement de buffer ac ctrl+tab
(global-set-key [(control tab)] 'other-window)

;;appelle la derniere macro enregistré
(global-set-key "\M-s" 'call-last-kbd-macro)
(global-set-key "\C-z" 'call-last-kbd-macro)

;;rotatethough the kill ring
(global-set-key (kbd "M-y") 'browse-kill-ring)
;; (global-set-key "\M-l" 'goto-line)


(global-set-key [M-return] 'senator-jump)

(global-set-key [f1] (lambda ()
                       (interactive)
                       (switch-to-buffer "*scratch*")
                       (ctafconf-help)
                       ))

(global-set-key [(shift f1)] (lambda ()
                               (interactive)
                               (woman (current-word))))

;; (global-set-key [f2] 'norme)
;; (global-set-key [(shift f2)] 'xterm-mouse-mode)
;; (global-set-key [f14] 'xterm-mouse-mode)
(global-set-key [f2] 'igrep)
(global-set-key [(shift f2)] 'igrep-find)
(global-set-key [f14] 'igrep-find)

(global-set-key [f3] 'query-replace)
(global-set-key [(shift f3)] 'replace-string)
(global-set-key [f15] 'replace-string)
(global-set-key [(control f3)]   'occur)

(global-set-key [f4] 'comment-region)
(global-set-key [(shift f4)] 'uncomment-region)
(global-set-key [f16] 'uncomment-region)

(global-set-key [f5] 'ansi-term)
(global-set-key [(shift f5)] 'sr-speedbar-toggle)
(global-set-key [f17] 'sr-speedbar-toggle)

(global-set-key [f6] 'bm-toggle)
(global-set-key [(shift f6)] 'bm-next)
(global-set-key [f18] 'bm-next)
(global-set-key [(control f6)] 'bm-previous)

(global-set-key [(f7)] 'marker-visit-next)
(global-set-key [(shift f7)] 'marker-visit-prev)
(global-set-key [(f19)] 'marker-visit-prev)

;;(global-set-key [f8] 'mode-compile)
(global-set-key [f8] 'compile)
(global-set-key [(shift f8)] 'gdb)
(global-set-key [f20] 'gdb)

(global-set-key [f9] 'next-error)
(global-set-key [(shift f9)] 'previous-error)
(global-set-key [(f21)] 'previous-error)

;;;;;; F7: Folding

(global-set-key (kbd "<f10>")       'fold-dwim-toggle)
(global-set-key (kbd "<S-f10>")     'fold-dwim-hide-all)
(global-set-key (kbd "<S-C-f10>")   'fold-dwim-show-all)
;;(global-set-key (kbd "<C-f10>")     'outline-next-visible-heading)
;;(global-set-key (kbd "<S-C-f10>")   'outline-previous-visible-heading)

(global-set-key (kbd "<f11>")       'gdb-many-windows)


(global-set-key [(f12)] '(lambda() (interactive) (scroll-other-window 1)))
(global-set-key [(shift f12)] '(lambda() (interactive) (scroll-other-window -1)))
(global-set-key [(f24)] '(lambda() (interactive) (scroll-other-window -1)))

;;jump to tag in semantic
(global-set-key [(control shift mouse-1)] 'semantic-ia-fast-mouse-jump)
