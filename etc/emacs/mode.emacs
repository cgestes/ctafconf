;;
;; mode.emacs for ctafconf in ~/.ctafconf/etc/emacs/mode.emacs
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 00:57:16 2006 GESTES Cedric
;; Last update Wed Apr 19 23:38:43 2006 GESTES Cedric
;;
(message "ctafconf loading: MODE.EMACS")

;;file extension mode
(setq auto-mode-alist
      (append
	'(
	  ("\\.txt$" . text-mode)
	  ("\\.dat$" . text-mode)
	  ("\\.pas$" . pascal-mode)
	  ("\\.java$" . c-mode)
	  ("\\.doc$" . plain-tex-mode)
	  ("\\.bib$" . bibtex-mode)
	  ("\\.bst$" . bst-mode)
	  (".emacs$" . emacs-lisp-mode)
	  ("emacs*" . emacs-lisp-mode)
	  ("*emacs$" . emacs-lisp-mode)
	  ("\\.tcsh*" . csh-mode)
          ("\\.[ly]$" . c-mode) ;; bison/flex
          ("\\.Xdefaults$"    . xrdb-mode)
          ("\\.Xenvironment$" . xrdb-mode)
          ("\\.Xresources$"   . xrdb-mode)
          ("\\.css$" . html-mode)
          ("\\.cfm$" . html-mode)
          ("\\.ml\\w?" . tuareg-mode)
          ("\\.adb\\'" . ada-mode)
          ("\\.ads\\'" . ada-mode)
          ("\\.e\\'" . eiffel-mode)
	  )
	auto-mode-alist)
      )

(condition-case err
    (progn
      (load "~/.ctafconf/etc/emacs/site-lisp/sieve/sieve")
      (add-to-list 'auto-mode-alist '("\\.siv$" . sieve-mode))
      (add-to-list 'auto-mode-alist '("\\.sieve$" . sieve-mode)))
(error
 (message "Cannot load sieve %s" (cdr err))))

(condition-case err
    (progn
      (require 'tiger nil t)
      (add-to-list 'auto-mode-alist '("\\.tig$" . tiger-mode)))
  (error
   (message "Cannot load tiger %s" (cdr err))))

;;tuareg-mode CAML
(condition-case err
    (progn
;;      (require 'tuareg nil t)
      (autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
      (autoload 'camldebug "camldebug" "Run the Caml debugger" t)
      (if (and (boundp 'window-system) window-system)
          (if (string-match "XEmacs" emacs-version)
              (require 'sym-lock)
            (require 'font-lock))))
  (error
   (message "Cannot load tuareg %s" (cdr err))))

;;editer les fichiers eiffel
(autoload 'eiffel-mode "eiffel-mode" "Major mode for Eiffel programs" t)

;;editer les fichiers ada
(autoload 'ada-mode "ada-mode" "Major mode for Ada programs" t)

;;IDO MODE
(condition-case err
    (progn
      (when (require 'ido nil t)
        ;;IDO for find-file, and others
        (ido-mode t))
      ;;IDO for switching between buffers
      ;;need to be after ido-mode
      (iswitchb-mode 1))
  (error
   (message "Cannot load ido %s" (cdr err))))
;;;//IDO MODE

;;auto-template for .cc, .c, .h, .hh, ...
(setq auto-template-dir "~/.ctafconf/etc/emacs/templates/")
(require 'auto-template "auto-template.el")

;;; bubble-buffer
(when (require 'bubble-buffer nil t)
  (global-set-key [f11] 'bubble-buffer-next)
  (global-set-key [(shift f11)] 'bubble-buffer-previous)
(setq bubble-buffer-omit-regexp "\\(^ .+$\\|\\*Messages\\*\\|*compilation\\*\\|\\*.+output\\*$\\|\\*TeX Help\\*$\\|\\*vc-diff\\*\\|\\*Occur\\*\\|\\*grep\\*\\|\\*cvs-diff\\*\\|\\*modelsim\\*\\)"))


(when (require 'ibuffer "ibuffer" t)
  (setq ibuffer-shrink-to-minimum-size t)
  ;;(setq ibuffer-always-show-last-buffer ':nomini)
  (setq ibuffer-always-show-last-buffer nil)
  (setq ibuffer-sorting-mode 'recency)
  (setq ibuffer-use-header-line t)
  (setq ibuffer-formats '((mark modified read-only " " (name 30 30)
                                " " (size 6 -1) " " (mode 16 16) " " filename)
                          (mark " " (name 30 -1) " " filename)))
  (define-key ibuffer-mode-map (kbd "#") 'ibuffer-switch-format))


;; indent =, <, ... in cmode
;;(require 'smart-operator)
;; (defun my-c-mode-common-hook()
;;   (smart-insert-operator-hook)
;;
;;   (local-unset-key (kbd "."))
;;   (local-unset-key (kbd ":"))
;;   (local-set-key (kbd "*") 'c-electric-star))
;;
;; (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


(condition-case err
    (progn
      ;;C-return => selection mode
      (if (boundp 'cua-mode)
          ;; For 21.3.50 and higher
          (cua-mode t)
        ;; For earlier emacs
        (load "cua")
        (CUA-mode t)))

  (error
   (message "Cannot load cua %s" (cdr err))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BOOKMARK
  ;; Make sure the repository is loaded as early as possible (for desktop-read)
(condition-case err
    (progn
      (setq bm-restore-repository-on-load t)
      (require 'bm)
      (setq-default bm-buffer-persistence t)
      ;; Restoring bookmarks when on file find.
      (add-hook 'find-file-hooks 'bm-buffer-restore)
      ;; Saving bookmark data on killing a buffer
      (add-hook 'kill-buffer-hook 'bm-buffer-save)
      ;; Saving the repository to file when on exit.
      ;; kill-buffer-hook is not called when emacs is killed, so we
      ;; must save all bookmarks first.  Ignore errors, so that Emacs
      ;; doesn't become unkillable.
      (add-hook 'kill-emacs-hook
                '(lambda nil (condition-case nil
                                 (progn
                                   (bm-buffer-save-all)
                                   (bm-repository-save)))))
      ;; Update bookmark repository when saving the file.
      (add-hook 'after-save-hook 'bm-buffer-save)
      ;; Restore bookmarks when buffer is reverted.
      (add-hook 'after-revert-hook 'bm-buffer-restore))
  (error
   (message "Cannot load bm %s" (cdr err))))

;; Gives us marker-visit-next and marker-visit-prev
(condition-case err
    (progn
      (require 'marker-visit))
  (error
   (message "Cannot load marker-visit %s" (cdr err))))

