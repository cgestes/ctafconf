;;
;; startup.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 01:00:22 2006 GESTES Cedric
;; Last update Mon Jan 16 09:59:51 2006 GESTES Cedric
;;
(message "ctafconf loading: STARTUP.EMACS")

;; Change startup message...
(defcustom hinitial-scratch-message (purecopy "\
;; CTAFCONF Emacs (www.noshell.info) -- for more help: M-x ct-help
;; to compile this conf 'emacs -batch -l ~/.ctafconf/etc/emacs/compile_conf.el'
;; you need, cedet, semantic and ilisp installed in .ctafconf/etc/emacs/site-lisp
;;
;; [S-left]     previous buffer         [S-right]       next buffer
;; [C-TAB]      change window           [C-c C-z]       zlock
;; [F1]         man                     [S-F1]
;; [F2]         check norme (epita)     [S-F2]          xterm-mouse on/off
;; [F3]         query-replace           [S-F3]          replace-string
;; [F4]         comment-region          [S-F4]          uncomment-region
;; [F5]         terminal                [S-F5]          speedbar
;; [F6]		Switch other buffer
;; [F7]		SpeedBar
;; [F8]		Compile
;; [F9]		Reindent current-file
;; [F10]	Reindent a Directory
;; [F11]	show ecb (code browser) [S-F11]         hide ecb (code browser)
;; [F12]	scroll-other-window     [S-F12]         scroll-other-window-down
;; [S-SPC]      inline completion
;; C-z          Recall last kbd macro
;; M-l          Goto-line
;; C-enter	Calculator
;; C--		undo
;; C-c r	revert buffer
;; M-x dos2unix	convert a Dos format to unix format
;; M-x setget to create {set,get}_var function (on the line)
;; M-x counter-reinitialize to give the parameters for counter
;; M-x counter-insert to use the counter
;;
;; emacs default keybinding
;; c-x c-e :evaluate elisp expression
;; c-x 4 a :add one entry to the ChangeLog

;; === TODO ===
;;  - shortcut: kill one line
;;  - c/c++ mode (epita indentation)
;;  - bash : tab = 2 space
;;  - kill space til one word
;;  - list all functions of one file
;;  - safe load
;;  - prev/next buffer
;;  - cwarn mode (global-cwarn-mode)
;;  - prev/next buffer
;;  - truncate line
;;  - cparse/ctype is now integrated into semantic
") "Initial message displayed in *scratch* buffer at startup.
If this is nil, no message will be displayed."
  :type 'string)

(with-current-buffer (get-buffer "*scratch*")
  (erase-buffer)
  (when hinitial-scratch-message
    (insert hinitial-scratch-message))
  (set-buffer-modified-p nil))

