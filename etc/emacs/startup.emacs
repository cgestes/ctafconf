;;
;; startup.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 01:00:22 2006 GESTES Cedric
;; Last update Thu Mar 23 01:24:30 2006 GESTES Cedric
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
;; [C-backspace]join-line               [C-b ]          buffer list
;; [F1]         SHOW THIS HELP          [S-F1]          man
;; [F2]         check norme (epita)     [S-F2]          xterm-mouse on/off
;; [F3]         query-replace           [S-F3]          replace-string
;; [F4]         comment-region          [S-F4]          uncomment-region
;; [F5]         terminal                [S-F5]          speedbar
;; [F6]         togle bookmark          [S/C-F6]        next/prev bookmark
;; [M-F6]       next mark               [C-M-F6]        prev mark (made with C-space)
;; [F7]		SpeedBar
;; [F8]		Compile                 [S-F8]          debug
;; [F9]		Reindent current-file
;; [F10]	Reindent a Directory
;; [F11]	show ecb (code browser) [S-F11]         hide ecb (code browser)
;; [F12][A-Pup]	scroll-other-window     [S-F12][A-Pdown]scroll-other-window-down
;; [S-SPC]      inline completion
;; C-z          Recall last kbd macro, C-x ( record, C-x ) stop recording
;; M-l          Goto-line
;; C-return     Box-mode selection
;; C--		undo
;; C-c r	revert buffer
;; M-x dos2unix	convert a Dos format to unix format
;; M-x setget to create {set,get}_var function (on the line)
;;?? M-x counter-reinitialize to give the parameters for counter
;;?? M-x counter-insert to use the counter
;; M-y yank cycle previous buffer
;;
;; emacs default keybinding
;; c-x c-e :evaluate elisp expression
;; c-x 4 a :add one entry to the ChangeLog

;; when opening file [C-UP], [C-DOWN] move up and down into the history
;; to get the standart open file [C-x f] then [C-f]
;; (usefull to open new file with a name shorter than one already existing)
;; === TODO ===
;;  - shortcut: kill one line
;;  - c/c++ mode (epita indentation)
;;  - bash : tab = 2 space
;;  - kill space til one word
;;  - list all functions of one file
;;  - prev/next buffer
;;  - truncate line
;;  - working directory for gdb/compile
;;  - switch key for group of windows in ecb
;;  - doxyemacs (auto comment, with good param)
;;  - tab-space
;;  - kill-word, kill-ring,..
;;  - match ( & co on cursor
;;  - svn
;;  - bookmark, folding
;;  - cache semantic => .ctafconf/perso
;;
;;easy emacs:
;;Ctrl-/         Bounce         Move from the beginning to the end or
;;               Expression     from the end to the beginning of a
;;                              balanced expression, such as one enclosed
;;                              by () [] or {}
;;
;;backspace kill the selection, shift up and down => selection
;; Ctrl-F5        Character      Duplicate the character from the line
;;                Above          above, and move one character forward.

;; Shft-Ctrl-F5   Character      Duplicate the character from the line
;;                Below          below, and move one character forward.
;; F7             Toggle Fold    If on a closed fold, open it; else close
;;                               the fold at the cursor
;; Alt-F7         Fold All       Hide all folds in the file or selected
;;                               region.
;; Shft-Alt-F7    Unfold All     Show all folds in the file or selected
;;                               region.
;; Ctrl-F7        Next Heading   Go to the next heading in the file (only
;;                               for file-types where that is meaningful).
;; Shft-Ctrl-F7   Previous       Go to the previous heading in the file.
;;                Heading

;;  === DOC ===
;;  see: http://www.dur.ac.uk/p.j.heslin/Software/Emacs/Easymacs
;;  =programming=
;;  =installing ecb,semantic, cedet, ilisp=
") "Initial message displayed in *scratch* buffer at startup.
If this is nil, no message will be displayed."
  :type 'string)

(with-current-buffer (get-buffer "*scratch*")
  (erase-buffer)
  (when hinitial-scratch-message
    (insert hinitial-scratch-message))
  (set-buffer-modified-p nil))

