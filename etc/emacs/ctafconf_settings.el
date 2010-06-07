;;
;; settings.emacs for ctafconf
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Mon Jan 16 01:13:33 2006 GESTES Cedric
;; Last update Thu May 27 19:33:40 2010 Cedric GESTES
;;

(message ".")
(message "ctafconf loading: SETTINGS.EMACS")

;;dont call the emacs debug on error (avoid annoying popup)
(setq debug-on-error nil)

(setq
 ;;TEST
 completion-auto-help t;; I want as much help as I can get
 completion-auto-exit t;; Don't want to always hit return
 bs-default-sort-name "by mode"
 garbage-collection-messages t)
;;/TEST

;; Distance between tab stops (for display of tab characters), in columns.
;; Automatically becomes buffer-local when set in any fashion.
(setq default-tab-width  8)
(setq sh-indentation     2)
(setq sh-indent-for-then 0)
(setq csh-indent         2)
(setq sh-basic-offset    2)
(setq standard-indent    2)
(setq perl-indent-level  2)


;; scroll the compilation window
(setq compilation-scroll-output t)

;;Use only space when indenting
;;setq-default: is like setq, but only the value in buffer that do not already define the value)
(setq-default indent-tabs-mode nil)

;;scroll avec la souris
(mouse-wheel-mode t)

;;coloration syntaxique
(global-font-lock-mode t)

;;organised buffer
(msb-mode t)

(defvar running-on-windows (memq system-type '(windows-nt cygwin)))
(defvar running-on-linux   (not running-on-windows))
(defvar running-on-x       (eq window-system 'x))

;;suppression du menu
(if (or running-on-x
        running-on-windows)
    (progn
      (menu-bar-mode   t)
      (tool-bar-mode   t)
      (scroll-bar-mode t))
  (progn
    (menu-bar-mode nil)
    (tool-bar-mode nil)
    (scroll-bar-mode nil))
  )

;; Avoid those crappy "tooltips":
(setq tooltip-delay 2)

;;ne coupe pas les ligne avec des $
;;(set-variable 'truncate-partial-width-windows nil)

;;(setq-default truncate-lines t)

;;affiche les lignes et les colonnes dans la barre en bas
(column-number-mode t)
(line-number-mode   t)

;; display the current time
;;(display-time)
;;(setq display-time-day-and-date t)
;;(setq display-time-24hr-format t)
;;(setq display-time-string-forms "%H:%M")
;;(setq display-time-string-forms "%H:%M" )

;; replace highlighted text with what I type rather than just
;; inserting at a point
(delete-selection-mode t)

;;supprime le bootsplash
(setq inhibit-startup-message t)

;; remove anoying bell
(setq bell-volume 0)

;; Non-nil means try to flash the frame to represent a bell.
(setq visible-bell nil)

;;supprime le bootspash gnus
;;(gnus-inhibit-startup-message t)

;; highlight during searching
(setq query-replace-highlight t)

;; highlight incremental search
(setq search-highlight        t)

;; highlight matches from searches
;;(setq isearch-highlight t)
(setq-default transient-mark-mode t)

(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))

;;backup everything in ~/.saves
(setq backup-by-copying         t                        ; don't clobber symlinks
      backup-directory-alist    '(("." . "~/.emacs.d/backup/emacs-backup"))    ; don't litter my fs tree
      delete-old-versions       t
      kept-new-versions         6
      kept-old-versions         2
      version-control           t
      auto-save-default t               ; auto-save on every visit
      auto-save-interval 200            ; input events between auto-saves
      auto-save-timeout 30)             ; use versioned backups

; yank to point rather than cursor
(setq mouse-yank-at-point t)

;;preverse position when scroling
;;(scroll-preserve-screen-position t)

;;want it?
;(setq kill-whole-line t)

;;TEST
(setq default-major-mode 'indented-text-mode)
;;(setq font-lock-support-mode 'lazy-lock-mode)
(setq font-lock-maximum-decoration t)

;;support de la souris dans les terminaux x
(xterm-mouse-mode 0)

;;show matching parenthese
(setq show-paren-delay 0)
(show-paren-mode t)


;; montre les lignes inutilisées et les limites d'un buffer
(setq-default indicate-empty-lines t)

(setq require-final-newline             t
      mode-require-final-newline        1)


;;transforme 'yes or no' en 'y or n'
(fset 'yes-or-no-p 'y-or-n-p)

;;change le comportement de backspace et de suppr
;;0 is the default for the linux console
(normal-erase-is-backspace-mode 0)

;; Displaying buffer's name on titlebar
(setq frame-title-format
      '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

;;; Display an ugly color when there is some space before EOL
;;(setq show-trailing-whitespace t)
;;(setq-default show-trailing-whitespace t)

;;show shorcut for the last executed command if available
(setq teach-extended-commands-p t)

; make scripts executable upon saving
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; indiquate buffer boundaries on the left fringe
(setq-default indicate-buffer-boundaries (quote left))
;;--------------------------------------------------------------------
;; support de mon clavier en mode console
(set-terminal-coding-system 'iso-8859-15-unix)
(set-keyboard-coding-system 'iso-8859-15-unix)
(set-language-environment 'Latin-1)



;;igrep
(safe-load "igrep")

;;sr-speedbar : speedbar in a frame
(safe-load "srspeedbar")
;; (if (fboundp 'sr-speedbar-open)
;;     (sr-speedbar-open))

;;display function's doc in the minibuffer for elisp
(require 'eldoc)
