;;
;; prog.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 01:14:21 2006 GESTES Cedric
;; Last update Tue Feb  6 06:31:59 2007 GESTES Cedric
;;

(message "ctafconf loading: PROG.EMACS")

;;epita header
(load "std.el")
(load "std_comment.el")

;;auto-template for .cc, .c, .h, .hh, ...
(setq auto-template-dir "~/.ctafconf/etc/emacs/templates/")
(require 'auto-template "auto-template.el")

;; Compilation Options
(setq compile-command "make -k")
;; little compilation window
(setq compilation-window-height 9)

;; Auto launch the modes auto-newline et hungry-delete-key
;;; `auto-newline' goto to the next and indent automaticaly for '{', '}'and ';'
;;; `hungry-delete-key' delete every space instead of one with backspace.
;;(add-hook 'c-mode-hook 'c-toggle-auto-hungry-state)
;;(add-hook 'c-mode-hook 'hs-minor-mode)
;;(add-hook 'c++-mode-hook 'c-toggle-auto-hungry-state)
;;(add-hook 'c++-mode-hook 'hs-minor-mode)

(load-file "~/.ctafconf/etc/emacs/site-lisp/echeck.el")
(load-file "~/.ctafconf/etc/emacs/site-lisp/norme.el")

;; (require 'cc-mode)
;; (add-to-list 'c-style-alist
;; 	     '("epita"
;; 	       (c-basic-offset . 2)
;; 	       (c-comment-only-line-offset . 0)
;; 	       (c-hanging-braces-alist     . ((substatement-open before after)))
;; 	       (c-offsets-alist . ((topmost-intro        . 0)
;; 				   (substatement         . +)
;; 				   (substatement-open    . 0)
;; 				   (case-label           . +)
;; 				   (access-label         . -)
;; 				   (inclass              . ++)
;; 				   (inline-open          . 0)))))

;; (set c-default-style "epita")

;; kill trailing white space on save
;;(autoload 'nuke-trailing-whitespace "whitespace" nil t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; easy commenting out of lines
(autoload 'comment-out-region "comment" nil t)

;; Load CEDET
(condition-case err
    (progn
      ;;(setq semantic-load-turn-useful-things-on t)
      (setq semantic-load-turn-everything-on t)
      (load-file "~/.ctafconf/etc/emacs/site-lisp/cedet/common/cedet.el")
      ;; * This turns on which-func support (Plus all other code helpers)
      (semantic-load-enable-excessive-code-helpers)
      ;;S-SPC for autocompletion
      (global-set-key '[33554464] 'semantic-complete-analyze-inline)
      (global-semantic-show-parser-state-mode 1)
      (global-semantic-decoration-mode 1)
      ;;(global-semantic-idle-completions-mode 1)
      ;;(global-semantic-highlight-edits-mode 1)
      ;;(global-semantic-show-unmatched-syntax-mode 0)
      (global-semantic-stickyfunc-mode 1)
      (setq semanticdb-default-save-directory "~/.ctafconf/perso/semantic")
      )
  (error
   (message "Cannot load CEDET %s" (cdr err))))

;; (global-highlight-changes 1)
;; (highlight-changes-rotate-faces)
;; (setq highlight-changes-colours
;;   '("yellow" "magenta" "blue" "maroon" "firebrick" "green4" "DarkOrchid"))


(condition-case err
    (progn
;;      (setq ecb-auto-activate t)
      (setq ecb-tip-of-the-day nil)
      ;;(require 'ecb nil t)
      (require 'ecb-autoloads)
      )
  (error
   (message "Cannot load ecb %s" (cdr err))))


;;DOXYMACS;;;;;;;;;;;;;;;;;;;;;;;;;
(condition-case err
    (progn
      (require 'doxymacs);; in your .emacs  file.
      (add-hook 'c-mode-common-hook'doxymacs-mode)
      (defun my-doxymacs-font-lock-hook ()
        (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
            (doxymacs-font-lock)))
      (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook))
  (error
   (message "Cannot load doxyemacs %s" (cdr err))))


;;ilisp mode;;;;;;;;;;;;;;;;;;;;;;;
(condition-case err
    (if (file-exists-p "~/.ctafconf/etc/emacs/site-lisp/ilisp/ilisp.el")
        (progn
          ;;support extension file
          (set-default 'auto-mode-alist
                       (append '(("\\.lisp$" . lisp-mode)
                                 ("\\.lsp$" . lisp-mode)
                                 ("\\.cl$" . lisp-mode))
                               auto-mode-alist))
          ;;C-c evalue l'exprression sur laquel le pointeur se trouve
          (setq lisp-mode-hook '(lambda () (require 'ilisp)
                                  (local-set-key "\C-c" 'eval-defun-lisp)))
          ;;pas de popup, scrollauto de la fenetre ilisp
          (setq ilisp-mode-hook '(lambda ()
                                   (setq lisp-no-popper t)
                                   (setq comint-always-scroll t)))
          (require 'ilisp)))
  (error
   (message "Cannot load ilisp %s" (cdr err))))

;;Python
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode)
            auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))

;;autoappend * when in /* */ comment
(autoload 'blockcomment-mode "block-comm" "" t)
(autoload 'turn-on-blockcomment-mode "block-comm" "" t)
(add-hook 'c-mode-hook 'turn-on-blockcomment-mode)
(add-hook 'c++-mode-hook 'turn-on-blockcomment-mode)

(condition-case err
    (progn
      (require 'mode-compile)
      )
	  (error
     (message "Cannot load mode-compile %s" (cdr err))))

;;for debbugging
(require 'gdb-ui)


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
