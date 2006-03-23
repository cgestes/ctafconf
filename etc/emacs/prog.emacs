;;
;; prog.emacs for ctafconf in /home/ctaf/IBC/batail_s-ibc2
;;
;; Made by GESTES Cedric
;; Login   <ctaf@epita.fr>
;;
;; Started on  Mon Jan 16 01:14:21 2006 GESTES Cedric
;; Last update Thu Mar 23 04:52:29 2006 GESTES Cedric
;;

(message "ctafconf loading: PROG.EMACS")

;;epita header
(load "std.el")
(load "std_comment.el")

;;CTYPE ;;;;;;;;;;;;;;;;;;;;;;;
;;permet de mettre en couleur les types persos:
;;(require 'ctypes nil t)
;;(setq ctypes-write-types-at-exit t)
;;(ctypes-read-file nil nil t t)
;;(ctypes-auto-parse-mode 1)

;;scanne le dossier courant a la recherche de nouveau type
;;(lambda()
;;  (interactive)
;;  (ctypes-dir "."))

;;CPARSE ;;;;;;;;;;;;;;;;;;;;;;;
;;activation de cparse: c en anglais, mais tt est dit ..
;; (require 'cparse nil t)
;; ;;(setq load-path (cons "~/cparse" load-path))
;; (autoload 'cparse-listparts "cparse"
;;   "List all the parts in the current buffer in another buffer." t)
;; (autoload 'cparse-open-on-line "cparse"
;;   "Grab the object under the cursor and find it's definition." t)
;; (autoload 'cpc-insert-function-comment "cpcomment"
;;   "Starting at pnt, look for a function definition.  If the definition
;; exists, parse for the name, else, fill everything in as null.  Then
;; insert the variable cpc-function-comment, and fill in the %s with the
;; parts determined.
;; If the comment already exists, this function will try to update only
;; the HISTORY part." t)
;; (autoload 'cpc-insert-new-file-header "cpcomment"
;;   "Insert a new comment describing this function based on the format
;; in the variable cpc-file-comment.  It is a string with sformat tokens
;; for major parts.  Optional HEADER is the header to use for the cpr
;; token" t)
;; (autoload 'cpr-store-in-header "cproto"
;;   "Grab the header from current position, load in the header file, and
;; make any needed substitutions to update the header file.  If the
;; function is static, then create needed stuff in this c file for the
;; prototype." t)

;; fold source file (semantic-tag-folding.el) need keybinding
;;(require 'semantic-tag-folding)
;;(global-semantic-tag-folding-mode t)

;; (defvar c-mode-map)
;; ;; encore kkes key binding pour utiliser cparse..
;; (defun cparse-setup-keybindings ()
;;   (define-key c-mode-map "\C-cp" 'cparse-listparts)
;;   (define-key c-mode-map "\C-co" 'cparse-open-on-line)
;;   (define-key c-mode-map "\C-cf" 'cpc-insert-new-file-header)
;;   (define-key c-mode-map "\C-c\C-h" 'cpr-store-in-header)
;;   (define-key c-mode-map "\C-c\C-d" 'cpr-insert-function-comment)
;;   )

;; (add-hook 'c-mode-common-hook 'cparse-setup-keybindings)

;;test it
;;(add-hook c++-mode-hook 'cparse-setup-keybindings)

;; Compilation Options
(setq compile-command "make -k")
;;(setq compilation-window-height 20)
  ;; little compilation window
(setq compilation-window-height 9)
;;CWARN (for old emacs i think)
;;(require 'cwarn)
;;(global-cwarn-mode 1)

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

;;shell indentation = 2 (bash script)
;;(setq sh-indent 2)
;;(setq sh-indent-comment t)

;; easy commenting out of lines
(autoload 'comment-out-region "comment" nil t)

;; Load CEDET
(condition-case err
    (progn
      ;;(setq semantic-load-turn-useful-things-on t)
      (setq semantic-load-turn-everything-on t)
      (load-file "~/.ctafconf/etc/emacs/site-lisp/cedet/common/cedet.el")
      ;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
      ;; Select one of the following:
      ;; * This is the default.  Enables the database and idle reparse engines
      ;;(semantic-load-enable-minimum-features)
      ;; * This enables some tools useful for coding, such as summary mode
      ;;   imenu support, and the semantic navigator
      ;;(semantic-load-enable-code-helpers)
      ;; * This enables even more coding tools such as the nascent intellisense mode
      ;;   decoration mode, and stickyfunc mode (plus regular code helpers)
      ;; (semantic-load-enable-guady-code-helpers)
      ;; * This turns on which-func support (Plus all other code helpers)
      (semantic-load-enable-excessive-code-helpers)
      ;;S-SPC
      (global-set-key '[33554464] 'semantic-complete-analyze-inline)
      (global-semantic-show-unmatched-syntax-mode 0)
      (global-semantic-show-parser-state-mode 1)
      (global-semantic-decoration-mode 1)
      (global-semantic-idle-completions-mode 1)
      (global-semantic-highlight-edits-mode 1)
      (global-semantic-stickyfunc-mode 1)

      (global-highlight-changes 1)
      (setq semanticdb-default-save-directory "~/.ctafconf/perso/semantic")
      ;;(global-set-key "\C-SPC" 'semantic-complete-analyze-inline)
      ;; This turns on modes that aid in grammar writing and semantic tool
      ;; development.  It does not enable any other features such as code
      ;; helpers above.
      ;; (semantic-load-enable-semantic-debugging-helpers)
      )
  (error
   (message "Cannot load CEDET %s" (cdr err))))



(condition-case err
    (progn
;;      (setq ecb-auto-activate t)
      (setq ecb-tip-of-the-day nil)
      ;;(require 'ecb nil t)
      (require 'ecb-autoloads)
      )
  (error
   (message "Cannot load ecb %s" (cdr err))))



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
