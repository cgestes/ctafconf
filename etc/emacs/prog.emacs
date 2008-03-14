;;
;; prog.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf42@gmail.com>
;;
;; Started on  Mon Jan 16 01:14:21 2006 GESTES Cedric
;; Last update Thu Mar  6 15:28:12 2008 Cedric GESTES
;;
(message ".")
(message "ctafconf loading: PROG.EMACS")

;;EPITA STUFF
;;that stuff suck
;;(load "std.el")
(load-file "~/.config/ctafconf/etc/emacs/site-lisp/ept/std_comment.el")
(load-file "~/.config/ctafconf/etc/emacs/site-lisp/echeck.el")
(load-file "~/.config/ctafconf/etc/emacs/site-lisp/norme.el")

;;php
(add-to-list 'auto-mode-alist (cons "\\.php[0-9]*$" 'php-mode))
(condition-case err
    (progn
      (load-file "~/.config/ctafconf/etc/emacs/site-lisp/ept/php-mode.el"))
  (error
   (message "Cannot load php-mode %s" (cdr err)))
  )

;;auto-template for .cc, .c, .h, .hh, ...
(setq auto-template-dir "~/.config/ctafconf/etc/emacs/templates/")
(require 'auto-template "auto-template.el")

;; Compilation Options
(setq compile-command "make -k")
;; little compilation window
(setq compilation-window-height 12)

;;igrep
(condition-case err
    (progn
      (require 'igrep)

;;use default c/h in c-mode
;; (put 'igrep-files-default 'c-mode
;;      (lambda () "*.[ch]"))

      )
  (error
   (message "Cannot load cc-mode with qtenable %s" (cdr err))))




;;ugly hack to make qt c++ file look nicer
(condition-case err
    (progn
      (require 'cc-mode)
      (setq c-basic-offset 2)
      (setq c-comment-only-line-offset 0)
      (setq c-offsets-alist '((statement-block-intro . +)
                               (substatement-open . 0)
                               (substatement-label . 0)
                               (label . 0)
                               (statement-cont . +)))
;;      (setq c-C++-access-key "\\<\\(slots\\|signals\\|private\\|protected\\|public\\)\\>[ \t]*[(slots\\|signals)]*[ \t]*:")
;;      (font-lock-add-keywords 'c++-mode '(("\\<\\(Q_OBJECT\\|public slots\\|public signals\\|private slots\\|private signals\\|protected slots\\|protected signals\\)\\>" . font-lock-constant-face)))
      )
  (error
   (message "Cannot load cc-mode with qtenable %s" (cdr err))))

;; kill trailing white space on save
;;(autoload 'nuke-trailing-whitespace "whitespace" nil t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; easy commenting out of lines
(autoload 'comment-out-region "comment" nil t)

;;autoappend * when in /* */ comment
(autoload 'blockcomment-mode "block-comm" "" t)
(autoload 'turn-on-blockcomment-mode "block-comm" "" t)
(add-hook 'c-mode-hook 'turn-on-blockcomment-mode)
(add-hook 'c++-mode-hook 'turn-on-blockcomment-mode)


;; (autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;;                     (load-library "hhm-config")
;;                     (setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
;;                     (setq auto-mode-alist (cons '("\\.asp$" . html-helper-mode) auto-mode-alist))
;;                     (setq auto-mode-alist (cons '("\\.phtml$" . html-helper-mode) auto-mode-alist))


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
(defun ctafconf-ilisp()
    (condition-case err
        (if (file-exists-p "~/.config/ctafconf/etc/emacs/site-lisp/ilisp/ilisp.el")
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
  )
(if enable-ilisp
    (ctafconf-ilisp))


;;Python
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode)
            auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))

;;provide the compilation mode
(condition-case err
    (progn
      (require 'mode-compile)
      )
  (error
   (message "Cannot load mode-compile %s" (cdr err))))

;;for debbugging
(condition-case err
    (progn
      (require 'gdb-ui)
      )
  (error
   (message "Cannot load gdb-ui %s" (cdr err))))


;;provide the sieve mode
(condition-case err
    (progn
      (load "~/.config/ctafconf/etc/emacs/site-lisp/sieve/sieve")
      (add-to-list 'auto-mode-alist '("\\.siv$" . sieve-mode))
      (add-to-list 'auto-mode-alist '("\\.sieve$" . sieve-mode)))
(error
 (message "Cannot load sieve %s" (cdr err))))

;;provide the tiger mode
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


;;provide cedet
(defun ctafconf-cedet ()
    (condition-case err
        (progn
          ;;(setq semantic-load-turn-useful-things-on t)
          ;;(setq semantic-load-turn-everything-on t)
          ;;(load-file "~/.config/ctafconf/etc/emacs/site-lisp/cedet/common/cedet.el")
	  (load-file "~/src/cedet/common/cedet.el")
          ;; * This turns on which-func support (Plus all other code helpers)
          (semantic-load-enable-excessive-code-helpers)
	  ;; (semantic-load-enable-guady-code-helpers)

          ;;S-SPC for autocompletion
          (global-set-key '[33554464] 'semantic-complete-analyze-inline)
;;          (global-semantic-show-parser-state-mode 1)
          (global-semantic-decoration-mode 1)
          ;;display a bar with the function name the cursor is in
;;          (global-semantic-stickyfunc-mode 1)
          (setq semanticdb-default-save-directory "~/.config/ctafconf/perso/semantic")
          ;;(global-semantic-idle-completions-mode 1)
          ;;(global-semantic-highlight-edits-mode 1)
          ;;(global-semantic-show-unmatched-syntax-mode 0)
          ;; (global-highlight-changes 1)
          ;; (highlight-changes-rotate-faces)
          ;; (setq highlight-changes-colours
          ;;   '("yellow" "magenta" "blue" "maroon" "firebrick" "green4" "DarkOrchid"))
          )
      (error
       (message "Cannot load CEDET %s" (cdr err))))
    )

;; Load CEDET
(if enable-cedet
    (ctafconf-cedet)
  )


;;provide ecb

(defun ctafconf-ecb ()
  (condition-case err
        (progn
          (setq ecb-auto-activate t)
          (setq ecb-tip-of-the-day nil)
          ;;(require 'ecb nil t)
          (require 'ecb-autoloads)
          )
      (error
       (message "Cannot load ecb %s" (cdr err))))
  )

(if enable-ecb
    (ctafconf-ecb))
