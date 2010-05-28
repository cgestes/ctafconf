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

;;only space when indenting
;; Emacs normally uses both tabs and spaces to indent lines. If you
;; prefer, all indentation can be made from spaces only. To request this,
;; set `indent-tabs-mode' to `nil'. This is a per-buffer variable;
;; altering the variable affects only the current buffer, but it can be
;; disabled for all buffers.
;; Use (setq ...) to set value locally to a buffer
;; Use (setq-default ...) to set value globally
;;
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
(setq tooltip-delay 9999)

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

;;supprimer les fichiers de backup(temporaire) en quittant
;;(setq make-backup-files nil)

(setq make-backup-files t               ; make ~ files
      ;; With nil, numbered backups are made only if they already exist.
      ;; A new backup version is made every time the file is loaded.
      ;;version-control nil ; set to t below if `backup-directory-alist' exists
      kept-old-versions 2
      kept-new-versions 2
      ;; Preserves permissions of file being edited. Also affects links.
      backup-by-copying nil
      backup-by-copying-when-linked t
      backup-by-copying-when-mismatch nil
      backup-by-copying-when-privileged-mismatch 200
      delete-old-versions t           ; auto-delete excess numbered backups
      delete-auto-save-files t          ; delete auto-save files on save
      auto-save-default t               ; auto-save on every visit
      auto-save-interval 200            ; input events between auto-saves
      auto-save-timeout 30)             ; seconds idleness before autosave

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
(show-paren-mode 1)


;; montre les lignes inutilisées et les limites d'un buffer
(setq-default indicate-empty-lines t)

;; A more fine-grained minibuffer completion feedback scheme.
;; Prospective completions are concisely indicated within the
;; minibuffer itself, with each successive keystroke.
(icomplete-mode t)

;; Non-nil if searches should ignore case
;;(setq case-fold-search t)

;; Non-nil means query-replace should preserve case in replacements
;;(setq case-replace t)

;; s'assurer que les fichiers comportent un retour a la ligne en fin
;; nil      n'ajoute pas de newline
;; non-nil  pose la question
;; t        rajoute les newlines automatiquement
(setq require-final-newline 1
      mode-require-final-newline 1)

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


;;backup everything in ~/.saves
(setq backup-by-copying         t                        ; don't clobber symlinks
      backup-directory-alist    '(("." . "~/.emacs.d/backup/emacs-backup"))    ; don't litter my fs tree
      delete-old-versions       t
      kept-new-versions         6
      kept-old-versions         2
      version-control           t)                       ; use versioned backups


;;igrep
(safe-load "igrep")
