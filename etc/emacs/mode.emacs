;;
;; mode.emacs for ctafconf in ~/.ctafconf/etc/emacs/mode.emacs
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 00:57:16 2006 GESTES Cedric
;; Last update Thu Jan 19 16:07:55 2006 GESTES Cedric
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
  (global-set-key [(shift f11)] 'bubble-buffer-previous))
(setq bubble-buffer-omit-regexp "\\(^ .+$\\|\\*Messages\\*\\|*compilation\\*\\|\\*.+output\\*$\\|\\*TeX Help\\*$\\|\\*vc-diff\\*\\|\\*Occur\\*\\|\\*grep\\*\\|\\*cvs-diff\\*\\|\\*modelsim\\*\\)")
